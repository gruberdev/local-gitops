all: install-taskfile

install-taskfile:
	@command -v task > /dev/null 2>&1 && echo "Task is already installed, ignoring." || (echo "Installing Task..." && curl --location https://taskfile.dev/install.sh -o install_task.sh && (if [ -w /usr/local/bin ]; then sh install_task.sh -d -b /usr/local/bin; else sudo sh install_task.sh -d -b /usr/local/bin; fi) && rm install_task.sh)
