;;; autoload.el -*- lexical-binding: t; -*-

;;;###autoload
(defun jm/toggle-theme ()
  "Toggle between dark and light themes"
  (interactive)
  (setq doom-theme
        (if (eq doom-theme 'doom-solarized-dark-high-contrast)
            'doom-solarized-light 'doom-solarized-dark-high-contrast))
  (doom/reload-theme))

