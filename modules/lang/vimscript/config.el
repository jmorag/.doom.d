;;; lang/vimscript/config.el -*- lexical-binding: t; -*-

(use-package! vimrc-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.vim\\(rc\\)?\\'" . vimrc-mode)))
