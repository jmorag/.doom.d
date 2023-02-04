(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("b5f5170101ae5f01c2310bbc8737ed7fa274332cb9ffbd978737336c27042d23" "4f1d2476c290eaa5d9ab9d13b60f2c0f1c8fa7703596fa91b235db7f99a9441b" default))
 '(lsp-rust-analyzer-proc-macro-enable t)
 '(safe-local-variable-values
   '((format-all-formatters
      ("Haskell" fourmolu))
     (lsp-rust-all-targets)
     (lsp-rust-analyzer-cargo-all-targets)
     (dante-target . "test:Testall")
     (haskell-process-type quote stack)
     (js-indent-level . 2)
     (haskell-process-type . stack-ghci)
     (haskell-process-type . stack)
     (projectile-project-run-cmd . "yarn start")
     (haskell-process-use-ghci . t)
     (haskell-indent-spaces . 2)
     (projectile-project-run-cmd . "./lantern -headless")
     (projectile-project-compilation-cmd . "make lantern")
     (projectile-project-compilation-cmd . "hugo server -D --disableFastRender")
     (projectile-project-compilation-cmd . "latexmk Morag_Thesis -bibtex -pdfxe -pvc -shell-escape")))
 '(warning-suppress-types '((iedit))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'narrow-to-region 'disabled nil)
(put 'magit-clean 'disabled nil)
