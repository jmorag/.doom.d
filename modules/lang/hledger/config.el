;;; lang/hledger/config.el -*- lexical-binding: t; -*-

(use-package! hledger-mode
  :defer t
  :init
  (add-hook 'ledger-mode-hook #'outline-minor-mode)
  :mode ("\\.journal\\'" "\\.hledger\\'"))

(use-package! flycheck-hledger
  :when (featurep! :checkers syntax)
  :after hledger-mode)
