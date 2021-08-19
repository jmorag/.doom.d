;;; autoload/hydra.el -*- lexical-binding: t; -*-
;;;###if (featurep! :ui hydra)

;;;###autoload
(defhydra +hydra/windower (:hint nil)
  "
^Move^                      ^Swap^
^^^^^^^^------------------------------------------------
_h_: move border left       _H_: swap border left
_j_: move border up         _J_: swap border above
_k_: move border down       _K_: swap border below
_l_: move border right      _L_: swap border right
                          _t_: toggle vertical or horizontal split
"
  ("h" windower-move-border-left)
  ("j" windower-move-border-below)
  ("k" windower-move-border-above)
  ("l" windower-move-border-right)
  ("<left>" windower-move-border-left)
  ("<down>" windower-move-border-below)
  ("<up>" windower-move-border-above)
  ("<right>" windower-move-border-right)
  ("H" windower-swap-left)
  ("J" windower-swap-below)
  ("K" windower-swap-above)
  ("L" windower-swap-right)
  ("<S-left>" windower-swap-left)
  ("<S-down>" windower-swap-below)
  ("<S-up>" windower-swap-above)
  ("<S-right>" windower-swap-right)
  ("t" windower-toggle-split :exit t)
  ("s" windower-swap :exit t)
  ("q" nil "cancel" :color blue)
  ("<return>" nil nil))

;;;###autoload
(defhydra +hydra/smerge ()
  "A hydra for smerge"
  ("j" smerge-next "next conflict")
  ("k" smerge-prev "previous conflict")
  ("u" smerge-keep-upper "keep upper conflict")
  ("l" smerge-keep-lower "keep lower conflict")
  ("l" smerge-keep-all "keep both")
  ("q" nil "cancel" :color blue))
