;; -*- no-byte-compile: t; -*-
;;; lang/unison/packages.el

(package! unisonlang-mode :recipe (:local-repo "Projects/unison-mode-emacs"))

(when (and (featurep! +lsp)
           (not (featurep! :tools lsp +eglot)))
  (package! lsp-unison :recipe (:local-repo "~/Projects/lsp-unison")))
