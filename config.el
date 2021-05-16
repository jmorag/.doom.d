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
(setq doom-theme 'doom-solarized-dark-high-contrast)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Dropbox/Agenda/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

(setq-default cursor-type '(bar . 2))
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
         ("f" make-frame)))
   ("C-h" windmove-left)
   ("C-j" windmove-down)
   ("C-k" windmove-up)
   ("C-l" windmove-right)
   ("g r" revert-buffer)
   ("C-u" scroll-down-command :first '(deactivate-mark))
   ("C-d" scroll-up-command :first '(deactivate-mark))
   ("!" shell-command)
   ("&" async-shell-command))
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
(electric-pair-mode 1)

(use-package! undo-fu
  :ryo
  ("u" undo-fu-only-undo)
  ("U" undo-fu-only-redo))
(use-package! helm
  :bind (:map helm-map
         ("C-j" . helm-next-line)
         ("C-k" . helm-previous-line)
         ("TAB" . helm-execute-persistent-action)
         ("<tab>" . helm-execute-persistent-action)
         ("C-z" . helm-select-action))
  :ryo
  ("P" helm-show-kill-ring))

(use-package! ivy
  :bind (:map ivy-minibuffer-map
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)))

(use-package! company
  :bind (:map company-active-map
         ("C-j" . company-select-next)
         ("C-k" . company-select-previous)
         ("<down>" . company-select-next)
         ("<up>" . company-select-previous)
         ("TAB" . nil)
         ("<tab>" . nil)))

(define-key! :keymaps +default-minibuffer-maps
  "C-j"    #'next-line
  "C-k"    #'previous-line
  "C-S-j"  #'scroll-up-command
  "C-S-k"  #'scroll-down-command)
(define-key! read-expression-map
  "C-j" #'next-line-or-history-element
  "C-k" #'previous-line-or-history-element)

(map!
 "C-z" nil
 (:map special-mode-map "j" #'next-line "k" #'previous-line)
 (:map ryo-modal-mode-map
  "SPC" doom-leader-map
  :desc "Undo window config"           "[ w" #'winner-undo
  :desc "Redo window config"           "] w" #'winner-redo
  :desc "Search buffer"                 "/"   #'+default/search-buffer
  (:when (featurep! :ui vc-gutter)
   :desc "Jump to next hunk"          "] g"   #'git-gutter:next-hunk
   :desc "Jump to previous hunk"      "[ g"   #'git-gutter:previous-hunk))
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
    :desc "SMerge"  "v m"   #'+vc/smerge-hydra/body))
  (:when (featurep! :completion helm)
   "b" #'helm-mini)
  (:when (featurep! :editor format)
   :desc "Format buffer/region"   "="   #'+format/region-or-buffer)))

(after! projectile
  (define-key ryo-modal-mode-map (kbd "SPC p") 'projectile-command-map)
  (map! (:leader
         :desc "Search project"        "/" #'+default/search-project
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

