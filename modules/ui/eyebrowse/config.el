;;; ui/workspaces/config.el -*- lexical-binding: t; -*-

(use-package! eyebrowse
  :config
  (eyebrowse-mode 1)
  (setq eyebrowse-wrap-around t)
  (setq eyebrowse-new-workspace t)
  (map! (:map ryo-modal-mode-map
         "; w" #'eyebrowse-close-window-config)
        (:leader
         :desc "Switch to workspace 0" "0" #'eyebrowse-switch-to-window-config-0
         :desc "Switch to workspace 1" "1" #'eyebrowse-switch-to-window-config-1
         :desc "Switch to workspace 2" "2" #'eyebrowse-switch-to-window-config-2
         :desc "Switch to workspace 3" "3" #'eyebrowse-switch-to-window-config-3
         :desc "Switch to workspace 4" "4" #'eyebrowse-switch-to-window-config-4
         :desc "Switch to workspace 5" "5" #'eyebrowse-switch-to-window-config-5
         :desc "Switch to workspace 6" "6" #'eyebrowse-switch-to-window-config-6
         :desc "Switch to workspace 7" "7" #'eyebrowse-switch-to-window-config-7
         :desc "Switch to workspace 8" "8" #'eyebrowse-switch-to-window-config-8
         :desc "Switch to workspace 9" "9" #'eyebrowse-switch-to-window-config-9)))
