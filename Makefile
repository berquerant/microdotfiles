.PHONY: install
install: init sh-minimal-init
	@echo "#############################################"
	@echo Please run 'source ~/.bashrc' and 'make emacs'
	@echo "#############################################"

.PHONY: sh-minimal-init
sh-minimal-init:
	make -C sh-minimal-init
	make -C sh-minimal-init gitconfig

.PHONY: init
init:
	git submodule update --init

.PHONY: emacs
emacs:
	./emacs.sh

.PHONY: update
update:
	git submodule update --remote
