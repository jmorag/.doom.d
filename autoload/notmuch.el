;;; autoload/notmuch.el -*- lexical-binding: t; -*-
;;;###if (featurep! :email notmuch)

;; The following stolen from evil-collection

;;;###autoload
(defun notmuch-toggle-tag (tag mode &optional next-function)
  "Toggle TAG tag for message in MODE."
  (let ((get (intern (format "notmuch-%s-get-tags" mode)))
        (set (intern (format "notmuch-%s-tag" mode)))
        (next (or next-function (intern (format "notmuch-%s-next-message" mode)))))
    (funcall set (list (concat (if (member tag (funcall get))
                                   "-" "+")
                               tag)))
    (funcall next)))

;;;###autoload
(defun notmuch-show-toggle-delete ()
  "Toggle deleted tag for message."
  (interactive)
  (notmuch-toggle-tag "deleted" "show"))

;;;###autoload
(defun notmuch-tree-toggle-delete ()
  "Toggle deleted tag for message."
  (interactive)
  (notmuch-toggle-tag "deleted" "tree"))

;;;###autoload
(defun notmuch-search-toggle-delete ()
  "Toggle deleted tag for message."
  (interactive)
  (notmuch-toggle-tag "deleted" "search" 'notmuch-search-next-thread))

;;;###autoload
(defun notmuch-tree-toggle-unread ()
  "Toggle unread tag for message."
  (interactive)
  (notmuch-toggle-tag "unread" "tree"))

;;;###autoload
(defun notmuch-search-toggle-unread ()
  "Toggle unread tag for message."
  (interactive)
  (notmuch-toggle-tag "unread" "search" 'notmuch-search-next-thread))

;;;###autoload
(defun notmuch-tree-toggle-flagged ()
  "Toggle flagged tag for message."
  (interactive)
  (notmuch-toggle-tag "flagged" "tree"))

;;;###autoload
(defun notmuch-search-toggle-flagged ()
  "Toggle flagged tag for message."
  (interactive)
  (notmuch-toggle-tag "flagged" "search"))
