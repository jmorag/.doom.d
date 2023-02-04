;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.


;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
;(package! some-package)

;; To install a package directly from a remote git repo, you must specify a
;; `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/raxod502/straight.el#the-recipe-format
;(package! another-package
;  :recipe (:host github :repo "username/repo"))

;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
;(package! this-package
;  :recipe (:host github :repo "username/repo"
;           :files ("some-file.el" "src/lisp/*.el")))

;; If you'd like to disable a package included with Doom, you can do so here
;; with the `:disable' property:
;(package! builtin-package :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
;(package! builtin-package :recipe (:nonrecursive t))
;(package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see raxod502/straight.el#279)
;(package! builtin-package :recipe (:branch "develop"))

;; Use `:pin' to specify a particular commit to install.
;(package! builtin-package :pin "1a2b3c4d5e")


;; Doom's packages are pinned to a specific commit and updated from release to
;; release. The `unpin!' macro allows you to unpin single packages...
;(unpin! pinned-package)
;; ...or multiple packages
;(unpin! pinned-package another-pinned-package)
;; ...Or *all* packages (NOT RECOMMENDED; will likely break things)
;(unpin! t)

(when (featurep! :editor evil)
  (package! expand-region))
(package! key-seq)
(package! ryo-modal :recipe (:repo "jmorag/ryo-modal"))
(package! kakoune :recipe (:local-repo "~/Projects/kakoune.el/" :files ("*.el")))
(package! aggressive-indent)
(package! evil-nerd-commenter)
(package! embrace)
(package! visual-regexp)
(package! phi-search)
(package! plus-minus :recipe
  (:host github :repo "peterwu/plus-minus" :branch "main"))
(package! dired-hacks-utils)
(package! dired-filter)
(package! dired-subtree)
(package! dired-narrow)
(package! peep-dired)
(package! bm)
(package! disk-usage)
(package! git-link)
(package! popper)
;; TODO: this could be a problem. See https://discourse.doomemacs.org/t/development-roadmap/42#do-not-pr
(package! format-all :pin "828280eaf3b46112e17746a7d03235570a633425")
(when (featurep! :completion helm)
  (package! helm-system-packages)
  ;; wgrep doesn't come with helm for some reason
  (package! wgrep :pin "f9687c28bbc2e84f87a479b6ce04407bb97cfb23")
  (package! helm-ag))
(package! shelldon :recipe (:host github :repo "Overdr0ne/shelldon"))
(package! windower)
(package! paren :disable t)
(package! bash-completion)
(package! gh-notify)
(package! ox-moderncv :recipe (:host github :repo "jmorag/org-cv"))
(package! suggest)
(package! smartparens :recipe (:host github :repo "jmorag/smartparens") :pin "512a3a5284d3ac537b7786692c2533678f87b919")
(unpin! lsp-haskell)
