;;; lang/graphviz/config.el -*- lexical-binding: t; -*-

(use-package! graphviz-dot-mode
  :config
  (setq graphviz-dot-indent-width 2))
(use-package! company-graphviz-dot)
