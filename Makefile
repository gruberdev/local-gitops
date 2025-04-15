.PHONY: all install-taskfile clean

# Default target
all: install-taskfile

# Detect OS
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Linux)
    OS := linux
endif
ifeq ($(UNAME_S),Darwin)
    OS := darwin
endif
ifeq ($(findstring MINGW,$(UNAME_S)),MINGW)
    OS := windows
endif

# Detect architecture
UNAME_M := $(shell uname -m)
ifeq ($(UNAME_M),x86_64)
    ARCH := amd64
endif
ifneq ($(filter %86,$(UNAME_M)),)
    ARCH := 386
endif
ifneq ($(filter arm%,$(UNAME_M)),)
    ARCH := arm
endif
ifeq ($(UNAME_M),aarch64)
    ARCH := arm64
endif

# Installation directory
ifeq ($(OS),windows)
    INSTALL_DIR := $(HOME)/bin
else
    INSTALL_DIR := /usr/local/bin
endif

# Check if sudo is needed
SUDO :=
ifeq ($(shell test -w $(INSTALL_DIR) || echo "no"),no)
    SUDO := sudo
endif

# Install Taskfile
install-taskfile:
	@echo "Detected OS: $(OS), Architecture: $(ARCH)"
	@if command -v task > /dev/null 2>&1; then \
		echo "Task is already installed, skipping installation."; \
	else \
		echo "Installing Task..."; \
		curl -sL https://taskfile.dev/install.sh -o install_task.sh; \
		$(SUDO) sh install_task.sh -d -b $(INSTALL_DIR); \
		rm install_task.sh; \
		echo "Task installed successfully."; \
	fi

# Clean up
clean:
	@echo "Cleaning up..."
	@if command -v task > /dev/null 2>&1 && [ -n "$(SUDO)" ]; then \
		$(SUDO) rm -f $(INSTALL_DIR)/task; \
	elif command -v task > /dev/null 2>&1; then \
		rm -f $(INSTALL_DIR)/task; \
	fi
	@echo "Task removed successfully."
