(defun smart-beginning-of-line ()
  "Smart home, for jumping to begining at the line."
  (interactive)
  (let ((oldpos (point)))
    (back-to-indentation)
    (and (= oldpos (point))
         (beginning-of-line))))

(global-set-key [home] 'smart-beginning-of-line)


;; (use-package bookmark
;;   :config
;;   (define-key global-map [menu-bar bookmarks]
;;     (cons "Bookmarks" (make-sparse-keymap "Bookmarks")))
;;   (define-key global-map
;;     [menu-bar bookmarks bookmark-insert]
;;     '("Insert bookmark into buffer" . bookmark-insert))
;;   (define-key global-map
;;     [menu-bar bookmarks bookmark-delete]
;;     '("Delete bookmark" . bookmark-delete))
;;   (define-key global-map
;;     [menu-bar bookmarks bookmark-save]
;;     '("Save bookmarks" . bookmark-save))
;;   (define-key global-map
;;     [menu-bar bookmarks list-bookmarks]
;;     '("List bookmarks" . list-bookmarks))
;;   (define-key global-map
;;     [menu-bar bookmarks bookmark-set]
;;     '("Add bookmark" . bookmark-sebt))
;;   (define-key global-map
;;     [menu-bar bookmarks bookmark-jump]
;;     '("Goto bookmark" . bookmark-jump)))


;; Editing defun

;; (defadvice kill-line (before check-position activate)
;;   (if (member major-mode
;;               '(emacs-lisp-mode clojure-mode scheme-mode lisp-mode c-mode 
;;                                 c++-mode objc-mode latex-mode plain-tex-mode))
;;       (if (and (eolp) (not (bolp)))
;;           (progn (forward-char 1)
;;                  (just-one-space 0)
;;                  (backward-char 1)))))

;; (defun kill-and-join-forward (&optional arg)
;;   (interactive "P")
;;   (if (and (eolp) (not (bolp)))
;;       (progn (forward-char 1)
;;              (just-one-space 0)
;;              (backward-char 1)
;;              (kill-line arg))
;;     (kill-line arg)))
;; (global-set-key "\C-k" 'kill-and-join-forward)

;; (defun kill-and-join-forward (&optional arg)
;;   "If at end of line, join with following; otherwise kill line.
;;                                         Deletes whitespace at join."
;;   (interactive "P")
;;   (if (and (eolp) (not (bolp)))
;;       (delete-indentation t)
;;     (kill-line arg)))

;; ;; https://www.emacswiki.org/emacs/AutoIndentation
;; (dolist (command '(yank yank-pop))
;;   (eval `(defadvice ,command (after indent-region activate)
;;            (and (not current-prefix-arg)
;;                 (member major-mode '(emacs-lisp-mode lisp-mode
;;                                                      clojure-mode    scheme-mode
;;                                                      haskell-mode    ruby-mode
;;                                                      rspec-mode      python-mode
;;                                                      c-mode          c++-mode
;;                                                      objc-mode       latex-mode
;;                                                      plain-tex-mode))
;;                 (let ((mark-even-if-inactive transient-mark-mode))
;;                   (indent-region (region-beginning) (region-end) nil))))))

;; https://github.com/syl20bnr/spacemacs/blob/master/layers/%2Bspacemacs/spacemacs-editing-visual/packages.el


(provide '_func)
