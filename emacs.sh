#!/bin/bash

set -e

d="$(cd "$(dirname "$0")" || exit 1; pwd)"
. "${d}/sh-minimal-init/common.sh"

if [ -z "$EMACSD" ] ; then
    cecho red "EMACSD is not set!"
    exit 1
fi

readonly site_lisp="${EMACSD}/site-lisp"
mkdir -p "$site_lisp"
ln -snvf "${d}/emacs-minimal-init" "${site_lisp}/emacs-minimal-init"

readonly init_el="${EMACSD}/init.el"
if grep -q "emacs-minimal-init" "$init_el" ; then
    cecho green "emacs-minimal-init is already linked!"
    exit
fi

cecho green "Append script to load emacs-minimal-init to ${init_el}."
cat - <<EOS >> "$init_el"
(add-to-list 'load-path "${site_lisp}/emacs-minimal-init")
(require 'minimal-init)
(minimal-init-setup)
EOS
