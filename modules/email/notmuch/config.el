;;; email/notmuch/config.el -*- lexical-binding: t; -*-

(use-package! notmuch
  :init
  (after! org
    (add-to-list 'org-modules 'ol-notmuch))
  :config
  (set-company-backend! 'notmuch-message-mode
    'notmuch-company '(company-ispell company-yasnippet))  :config
  (setq notmuch-search-oldest-first nil
        send-mail-function 'sendmail-sent-it
        sendmail-program "msmtp"
        message-send-mail-function 'message-send-mail-with-sendmail
        notmuch-poll-script "/home/joseph/Mail/checkmail.sh"
        notmuch-show-logo nil
        mm-text-html-renderer 'shr
        notmuch-multipart/alternative-discouraged '()
        notmuch-always-prompt-for-sender t)
  (map!
   "C-c m" #'notmuch
   :map notmuch-search-mode-map
   "u" #'notmuch-search-toggle-unread
   "f" #'notmuch-search-toggle-flagged
   "j" #'notmuch-search-next-thread
   "k" #'notmuch-search-previous-thread
   "e" #'notmuch-search-next-thread
   "i" #'notmuch-search-previous-thread
   ";" #'notmuch-jump-search
   "K" #'notmuch-tag-jump
   :map notmuch-tree-mode-map
   "u" #'notmuch-tree-toggle-unread
   "f" #'notmuch-tree-toggle-flagged
   "j" #'notmuch-tree-next-matching-message
   "k" #'notmuch-tree-prev-matching-message
   "e" #'notmuch-tree-next-matching-message
   "i" #'notmuch-tree-prev-matching-message
   ";" #'notmuch-jump-search
   "K" #'notmuch-tag-jump))


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
