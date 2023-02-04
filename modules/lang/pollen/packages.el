;; -*- no-byte-compile: t; -*-
;;; lang/pollen/packages.el

(package! pollen-mode :pin "19174fab69ce4d2ae903ef2c3da44054e8b84268")
(when (modulep! :completion company)
  (package! company-pollen))
