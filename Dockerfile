# Build stage
FROM golang:1.22-alpine as build

# Set the working directory inside the container
WORKDIR /app

# Install required dependencies in a single RUN statement
RUN apk add --no-cache git ca-certificates

# Clone PocketBase repository and your custom code
RUN git clone https://github.com/oilik/pocketbase-starter.git /app


# Set environment variables for the build process, CGO disabled for static linking
RUN go env -w GO111MODULE=on CGO_ENABLED=0

# Build the PocketBase executable
RUN go build -o pocketbase .


# Final stage
FROM scratch

# Copy the PocketBase executable from the build stage
COPY --from=build /app/pocketbase /pocketbase

# Expose the port PocketBase will run on
EXPOSE 8090

# Command to run the PocketBase server
CMD ["/pocketbase", "serve", "--http=0.0.0.0:8090"]
