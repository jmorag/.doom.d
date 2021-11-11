;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Joseph Morag"
      user-mail-address "jm@josephmorag.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-solarized-dark-high-contrast
      doom-variable-pitch-font "Linux Libertine O")

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Dropbox/Agenda/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

(setq-default cursor-type '(bar . 2))
(delete-selection-mode 0)
(setq standard-indent 2)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;; (after! evil
;;   (setq evil-escape-key-sequence "fd"))
(use-package! which-key
  :custom (which-key-idle-delay 0.2)
  :config
  (push '((nil . "ryo:.*:") . (nil . "")) which-key-replacement-alist))

(use-package! kakoune :init (kakoune-setup-keybinds))
(use-package! ryo-modal
  :init
  (ryo-modal-keys
   (:mc-all 0)
   ("," save-buffer)
   ("m" mc/mark-next-like-this)
   ("M" mc/skip-to-next-like-this)
   ("n" mc/mark-previous-like-this)
   ("N" mc/skip-to-previous-like-this)
   ("M-m" mc/edit-lines)
   ("*" mc/mark-all-like-this)
   ("v" er/expand-region)
   ("C-v" rectangle-mark-mode)
   ("M-s" mc/split-region)
   (";" (("q" delete-window)
         ("v" split-window-horizontally)
         ("s" split-window-vertically)
         ("f" make-frame)
         ("i" doom/goto-private-config-file)))
   ("C-h" windmove-left)
   ("C-j" windmove-down)
   ("C-k" windmove-up)
   ("C-l" windmove-right)
   ("g r" revert-buffer)
   ("C-u" scroll-down-command :first '(deactivate-mark))
   ("C-d" scroll-up-command :first '(deactivate-mark)))
  :config
  (add-hook! (prog-mode org-mode markdown-mode) #'ryo-modal-mode))

(use-package! key-seq
  :init
  (key-chord-mode 1)
  (defun ryo-enter () (interactive) (ryo-modal-mode 1))
  (key-seq-define-global "fd" #'ryo-enter)
  (global-set-key (kbd "<escape>") #'ryo-enter))

(use-package! aggressive-indent
  :config
  (add-hook!
    (racket-mode emacs-lisp-mode clojure-mode scheme-mode lisp-mode lisp-interaction-mode)
    #'aggressive-indent-mode))

(use-package! undo-fu
  :ryo
  ("u" undo-fu-only-undo)
  ("U" undo-fu-only-redo))

(use-package! wgrep)

(use-package! helm
  :when (featurep! :completion helm)
  :bind (:map helm-map
         ("C-j" . helm-next-line)
         ("C-k" . helm-previous-line)
         ("TAB" . helm-execute-persistent-action)
         ("<tab>" . helm-execute-persistent-action)
         ("C-z" . helm-select-action))
  :config
  (helm-autoresize-mode 1)
  (setq helm-ff-DEL-up-one-level-maybe t
        helm-window-prefer-horizontal-split t
        helm-split-window-inside-p t))

(use-package! helm-ag
  :when (featurep! :completion helm))

(use-package! helm-bibtex
  :when (featurep! :completion helm)
  :custom ((helm-bibtex-full-frame nil)
           (bibtex-completion-bibliography '("~/NYU/references/papers.bib"))
           (bibtex-completion-library-path '("~/NYU/references/"))))

(use-package! ivy
  :when (or (featurep! :completion helm) (featurep! :completion ivy))
  :custom (ivy-wrap nil)
  :bind (:map ivy-minibuffer-map
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)))

(use-package! vertico
  :when (featurep! :completion vertico)
  :bind (:map vertico-map
         ("C-j" . vertico-next)
         ("C-k" . vertico-previous)))

(use-package! company
  :bind (:map company-active-map
         ("C-j" . company-select-next)
         ("C-k" . company-select-previous)
         ("<down>" . company-select-next)
         ("<up>" . company-select-previous)
         ("<tab>" . nil)))

(define-key! read-expression-map
  "C-j" #'next-line-or-history-element
  "C-k" #'previous-line-or-history-element)

(map!
 "C-z" nil
 "C-;" nil
 (:map special-mode-map "j" #'next-line "k" #'previous-line)
 (:map ryo-modal-mode-map
  (:when (featurep! :ui hydra)
   "C-w" #'+hydra/windower/body)
  "SPC" doom-leader-map
  :desc "Undo window config"           "[ w" #'winner-undo
  :desc "Redo window config"           "] w" #'winner-redo
  :desc "Search buffer"                 "/"   #'+default/search-buffer
  "P" #'yank-pop
  (:when (featurep! :ui vc-gutter)
   :desc "Jump to next hunk"          "] g"   #'git-gutter:next-hunk
   :desc "Jump to previous hunk"      "[ g"   #'git-gutter:previous-hunk
   :desc "Revert hunk"                "g R"   #'git-gutter:revert-hunk))
 (:leader
  (:when (featurep! :ui workspaces)
   :desc "Switch to 1st workspace" "1" #'+workspace/switch-to-0
   :desc "Switch to 2nd workspace" "2" #'+workspace/switch-to-1
   :desc "Switch to 3rd workspace" "3" #'+workspace/switch-to-2
   :desc "Switch to 4th workspace" "4" #'+workspace/switch-to-3
   :desc "Switch to 5th workspace" "5" #'+workspace/switch-to-4
   :desc "Switch to 6th workspace" "6" #'+workspace/switch-to-5
   :desc "Switch to 7th workspace" "7" #'+workspace/switch-to-6
   :desc "Switch to 8th workspace" "8" #'+workspace/switch-to-7
   :desc "Switch to 9th workspace" "9" #'+workspace/switch-to-8
   :desc "Switch to final workspace" "0" #'+workspace/switch-to-final)
  :desc "Help" "h" help-map
  (:when (featurep! :tools magit)
   :desc "Magit status"  "g"   #'magit-status
   (:when (featurep! :ui hydra)
    :desc "SMerge"  "s"   #'+hydra/smerge/body))
  (:when (featurep! :completion helm)
   "b" #'helm-mini)
  (:when (featurep! :editor format)
   :desc "Format buffer"   "="   #'format-all-buffer)
  (:when (featurep! :tools taskrunner)
   :desc "Run tasks"       "t"   #'+taskrunner/project-tasks)))
(setq +format-with-lsp nil)

(after! projectile
  (define-key ryo-modal-mode-map (kbd "SPC p") 'projectile-command-map)
  ;; Don't override projectile-compile-project with ivy version
  (define-key! [remap projectile-compile-project] #'projectile-compile-project)
  (map! (:leader
         :desc "Search project"        "/" #'+default/search-project
         (:when (featurep! :completion helm)
          :desc "search project"       "/" #'helm-do-ag-project-root)
         :desc "Find file in project"  "SPC"  #'projectile-find-file
         :desc "Jump to bookmark"      "RET"  #'bookmark-jump)))

(use-package! embrace
  :ryo
  ("S" embrace-commander))

(use-package! evil-nerd-commenter
  :ryo
  (:mc-all t)
  ("'" evilnc-comment-or-uncomment-lines))

(use-package! flycheck
  :ryo
  ("] e" flycheck-next-error :first '(deactivate-mark))
  ("[ e" flycheck-previous-error :first '(deactivate-mark)))

(use-package! avy
  :ryo
  ("f" avy-goto-char-in-line :first '(deactivate-mark))
  ("F" avy-goto-char-in-line :first '(set-mark-if-inactive))
  ("C-f" avy-goto-char-timer :first '(deactivate-mark)))

(use-package! phi-search
  :bind (("C-s" . phi-search)
         ("C-r" . phi-search-backward)))

(after! lsp-clangd
  (setq lsp-clients-clangd-args '("-j=3"
                                  "--background-index"
                                  "--clang-tidy"
                                  "--completion-style=detailed"
                                  "--header-insertion=never"))
  (set-lsp-priority! 'clangd 2))

(use-package! dired-hacks-utils
  :config
  (map! :map dired-mode-map
        ";" #'wdired-change-to-wdired-mode
        "h" #'dired-up-directory
        "j" #'dired-hacks-next-file
        "k" #'dired-hacks-previous-file
        "l" #'dired-find-alternate-file
        "K" #'dired-do-kill-lines
        :leader
        :desc "Dired" "d" #'dired-jump))

(use-package! dired-narrow
  :bind (:map dired-mode-map
         ("f" . dired-narrow)
         ("/" . dired-narrow)))

(use-package! dired-subtree
  :bind (:map dired-mode-map
         ("i" . dired-subtree-toggle)
         ("C-j" . dired-subtree-next-sibling)
         ("C-k" . dired-subtree-previous-sibling)))

(use-package! peep-dired
  :custom
  (peed-dired-cleanup-on-disable t)
  (peep-dired-enable-on-directories t)
  :bind (:map dired-mode-map
         ("p" . peep-dired)
         :map peep-dired-mode-map
         ("j" . peep-dired-next-file)
         ("k" . peep-dired-prev-file)))

(use-package! magit
  :custom (git-commit-summary-max-length 68)
  :bind
  (:map magit-status-mode-map
   ("j" . magit-section-forward)
   ("k" . magit-section-backward)
   ("C-j" . magit-section-forward-sibling)
   ("C-k" . magit-section-backward-sibling)
   ("g" . magit-status-jump)
   ("p" . magit-push)
   ("P" . magit-pull)
   ("M-k" . magit-discard)
   :map magit-log-mode-map
   ("j" . magit-section-forward)
   ("k" . magit-section-backward))
  :config
  (transient-append-suffix 'magit-merge 'magit-merge:--strategy-option
    '("-a" "Allow unrelated histories" "--allow-unrelated-histories")))

(use-package! haskell-mode
  :hook
  (haskell-mode . (lambda ()
                    (haskell-indentation-mode 0)
                    (haskell-decl-scan-mode 1))))

(use-package! clj-refactor
  :bind (:map clj-refactor-map ("/" . nil)))

(map! :map +doom-dashboard-mode-map
      "j" #'+doom-dashboard/forward-button
      "k" #'+doom-dashboard/backward-button)

;; Bookmarks - https://github.com/joodland/bm
(use-package! bm
  :custom
  ((bm-cycle-all-buffers t)
   (bm-marker 'bm-marker-right))
  :ryo
  ("z" bm-toggle)
  ("] z" bm-next)
  ("[ z" bm-previous)
  :config
  ;; Loading the repository from file when on start up.
  (add-hook 'after-init-hook 'bm-repository-load)

  ;; Saving bookmarks
  (add-hook 'kill-buffer-hook #'bm-buffer-save)

  ;; Saving the repository to file when on exit.
  ;; kill-buffer-hook is not called when Emacs is killed, so we
  ;; must save all bookmarks first.
  (add-hook 'kill-emacs-hook #'(lambda nil
                                 (bm-buffer-save-all)
                                 (bm-repository-save)))

  ;; The `after-save-hook' is not necessary to use to achieve persistence,
  ;; but it makes the bookmark data in repository more in sync with the file
  ;; state.
  (add-hook 'after-save-hook #'bm-buffer-save)

  ;; Restoring bookmarks
  (add-hook 'find-file-hooks   #'bm-buffer-restore)
  (add-hook 'after-revert-hook #'bm-buffer-restore)

  ;; The `after-revert-hook' is not necessary to use to achieve persistence,
  ;; but it makes the bookmark data in repository more in sync with the file
  ;; state. This hook might cause trouble when using packages
  ;; that automatically reverts the buffer (like vc after a check-in).
  ;; This can easily be avoided if the package provides a hook that is
  ;; called before the buffer is reverted (like `vc-before-checkin-hook').
  ;; Then new bookmarks can be saved before the buffer is reverted.
  ;; Make sure bookmarks is saved before check-in (and revert-buffer)
  (add-hook 'vc-before-checkin-hook #'bm-buffer-save))

(use-package! disk-usage
  :bind (:map disk-usage-mode-map
         ("j" . next-line)
         ("k" . previous-line)
         ("H" . disk-usage-toggle-human-readable)
         ("h" . disk-usage-up)
         :map dired-mode-map
         ("," . disk-usage-here)))

(use-package! git-timemachine
  :ryo
  ("SPC G" git-timemachine)
  :bind
  (:map git-timemachine-mode-map
   ("j" . git-timemachine-show-next-revision)
   ("k" . git-timemachine-show-previous-revision)
   ("," . write-file)))

(use-package! git-link
  :custom (git-link-use-commit t))

(use-package! popper
  ;; Use emacs native window display options
  :custom (popper-display-control nil)
  :ryo
  ("q" popper-toggle-latest)
  ("Q" popper-cycle)
  ("C-q" popper-toggle-type)
  ("C-S-q" popper-kill-latest-popup)
  :bind (("C-="   . popper-toggle-latest)
         ("M-="   . popper-cycle)
         ("C-M-=" . popper-toggle-type))
  :init
  (setq popper-reference-buffers
        '("\\*Messages\\*"
          "Output\\*$"
          "Warnings"
          "\\*Async Shell Command\\*"
          "\\*Shell Command\\*"
          "\\*shelldon"
          help-mode
          helpful-mode
          compilation-mode
          Man-mode
          Comint
          haskell-interactive-mode
          inferior-python-mode)
        popper-group-function #'popper-group-by-projectile)
  (popper-mode +1))

(use-package! lsp
  :init
  (setq lsp-keymap-prefix "M-l")
  :config
  (setq lsp-ui-sideline-enable nil))

(setq enable-local-variables t)
(setq! +zen-text-scale 1.1
       writeroom-width 0.6)
(map! (:leader
       "o p" #'+zen/toggle
       "o l" #'jm/toggle-theme))

(setq! compilation-scroll-output t
       comint-buffer-maximum-size 1024
       shell-command-prompt-show-cwd t)

(use-package! shelldon
  :config
  (map! :map ryo-modal-mode-map
        "&" #'shelldon-output-history
        "e" #'shelldon
        "E" #'shelldon-loop)
  (add-hook! 'shelldon-mode-hook
             #'(lambda () (view-mode-disable) (ryo-modal-mode))))

(use-package! proced
  :bind (:map proced-mode-map
         ("j" . next-line)
         ("k" . previous-line)
         ("K" . (lambda () (interactive)
                  (proced-send-signal "KILL" (proced-marked-processes))
                  (revert-buffer)))))

(use-package! notmuch
  :custom (notmuch-search-oldest-first nil)
  :config
  (setq! send-mail-function 'sendmail-sent-it
         sendmail-program "msmtp"
         message-send-mail-function 'message-send-mail-with-sendmail
         notmuch-poll-script "/home/joseph/Mail/checkmail.sh"
         notmuch-show-logo nil
         mm-text-html-renderer 'shr
         notmuch-multipart/alternative-discouraged '()
         notmuch-always-prompt-for-sender t
         notmuch-saved-searches
         '((:name "inbox" :query "tag:inbox date:30d..now" :key "i")
           (:name "unread" :query "tag:unread" :key "u")
           (:name "flagged" :query "tag:flagged" :key "f")
           (:name "sent" :query "tag:sent" :key "t")
           (:name "drafts" :query "tag:draft" :key "d")
           (:name "all mail" :query "date:30d..now" :key "a")
           (:name "digest" :query "tag:digest")
           (:name "lists" :query "tag:lists")
           (:name "recurse" :query "to:@lists.community.recurse.com")))
  (map!
   "C-c m" #'notmuch
   ;; (:when (featurep! :completion helm) "C-c m" #'helm-notmuch)
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

(use-package! highlight-indent-guides
  :config
  (remove-hook! '(prog-mode-hook text-mode-hook conf-mode-hook)
    #'highlight-indent-guides-mode)
  (add-hook! 'shakespeare-hamlet-mode-hook #'highlight-indent-guides-mode))

;; (use-package! org-re-reveal
;;   :config
;;   (setq org-re-reveal-root "/home/joseph/Projects/reveal.js"))
