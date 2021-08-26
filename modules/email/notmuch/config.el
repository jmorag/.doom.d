;;; email/notmuch/config.el -*- lexical-binding: t; -*-

(use-package! notmuch
  :custom (notmuch-search-oldest-first nil)
  :init
  (after! org
    (add-to-list 'org-modules 'ol-notmuch))
  :config
  (set-company-backend! 'notmuch-message-mode
    'notmuch-company '(company-ispell company-yasnippet)))

(use-package! org-mime
  :after (org notmuch)
  :config (setq org-mime-library 'mml))

(use-package! counsel-notmuch
  :when (featurep! :completion ivy)
  :commands counsel-notmuch
  :after notmuch)

(use-package! helm-notmuch
  :when (featurep! :completion helm)
  :commands helm-notmuch
  :after notmuch)

(use-package! consult-notmuch
  :when (featurep! :completion vertico)
  :commands consult-notmuch
  :after notmuch)
