# Go parameters
GOCMD=go
GOBUILD=$(GOCMD) build
GOCLEAN=$(GOCMD) clean
GOTEST=$(GOCMD) test
GOGET=$(GOCMD) get
BINARY_NAME=hdkeychain
BINARY_UNIX=$(BINARY_NAME)_unix
BUILD_ENV=CGO_ENABLED=0 GOTRACEBACK=none
all: clean deps test build
build: 
		$(BUILD_ENV) $(GOBUILD) -o $(BINARY_NAME) -v
test: 
		$(GOTEST) -v ./...
clean: 
		$(GOCLEAN)
		rm -f $(BINARY_NAME)*
run: 	build
		./$(BINARY_NAME)
deps:
		$(GOGET) github.com/axw/gocov/gocov
		$(GOGET) github.com/btcsuite/btcd/chaincfg
		$(GOGET) github.com/btcsuite/btcd/btcec
		$(GOGET) github.com/btcsuite/btcd/chaincfg
		$(GOGET) github.com/btcsuite/btcd/chaincfg/chainhash
		$(GOGET) github.com/btcsuite/btcutil
		$(GOGET) github.com/btcsuite/btcutil/base58


# Cross compilation
build-linux:
		$(BUILD_ENV) GOOS=linux GOARCH=amd64 $(GOBUILD) -o $(BINARY_UNIX) -v