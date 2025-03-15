# Multi-Stage Builds
Такой подход оптимизирует `Docker Image` для деплоя за счет значительного уменьшения размера образа, эффективности и безопасности. Это разделение `Docker Image` на `Stage's`:
1. `Build Stage`: сборка с помощью компилятора языка программирования;
2. `Runtime Stage`: собирает минимальный `Docker Image` из артефакта `Build Stage` (только исполняемые файлы).

> Ранее устоявшейся практикой было отделение **образа для сборки** от **образа для запуска**. Это экономило размер итогового образа, так как на выходе софт, который нужен для сборки, не всегда нужен для работы, например, для сборки программы на C++ или Go понадобится компилятор, но полученный бинарник можно запускать уже без компилятора. При этом софт, необходимый для сборки, может весить намного больше, чем полученный артефакт.
Второй недостаток вытекает из первого: больше софта в итоговом образе — больше уязвимостей, а значит, мы теряем в безопасности наших сервисов.

```jsx title="Предположим, у вас есть простое приложение Go, которое нужно сбилдить и запустить внутри контейнера:" showLineNumbers
# --- Stage 1: Build ---
FROM golang:1.21-alpine AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy Go module files and download dependencies
COPY go.mod go.sum ./
RUN go mod download

# Copy source code and build the binary
COPY . .
RUN go build -o myapp ./cmd/myapp

# --- Stage 2: Runtime ---
FROM alpine:3.19

# Set a non-root user for security (optional but recommended)
RUN adduser -D appuser
USER appuser

# Set the working directory
WORKDIR /app

# Copy the binary from the builder stage
COPY --from=builder /app/myapp .

# Define the entrypoint
ENTRYPOINT ["./myapp"]
```

## Stage 1 (builder)
- Uses a full Golang image (golang:1.21-alpine) containing the compiler and necessary build tools.
- Downloads dependencies and compiles the Go application.

## Stage 2 (runtime)
- Uses a minimal Alpine Linux image (alpine:3.19) that significantly reduces the container size and attack surface.
- Copies the pre-built application binary from the first stage.
- Runs the application as a non-root user for improved security.

## Building the Docker image
```bash
docker build -t myapp:latest .
```
