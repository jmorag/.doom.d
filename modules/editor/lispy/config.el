;;; editor/lispy/config.el -*- lexical-binding: t; -*-

(use-package! lispy
  :config
  (add-hook 'ryo-modal-mode-hook
            (lambda ()
              (when (lispy--major-mode-lisp-p)
                (if (bound-and-true-p ryo-modal-mode)
                    (lispy-mode -1)
                  (lispy-mode 1))))))
