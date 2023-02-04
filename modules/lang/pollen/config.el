;;; lang/pollen/config.el -*- lexical-binding: t; -*-

(use-package! pollen-mode
  :mode "\\.pp\\'"
  :config
  (when (modulep! :completion company)
    (require 'company-pollen)))
