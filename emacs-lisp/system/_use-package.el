;; Extending use-package with new keywords - :doc :hot-key :tag
;; https://github.com/jwiegley/use-package#extending-use-package-with-new-or-modified-keywords
;; (setq use-package-debug t)

;; (use-package :doc "")

(eval-when-compile
  (require 'use-package))

(add-to-list 'use-package-keywords :doc)

(defun use-package-normalize/:doc (name keyword args)
  "Do nothing"
  nil)

(defun use-package-handler/:doc (name keyword arg rest state)
  "Do nothing"
  (let ((body (use-package-process-keywords name rest state)))
    body))

;; (use-package :hot-key "")

(add-to-list 'use-package-keywords :hot-key)

(defun use-package-normalize/:hot-key (name keyword args)
  "Do nothing"
  nil)

(defun use-package-handler/:hot-key (name keyword arg rest state)
  "Do nothing"
  (let ((body (use-package-process-keywords name rest state)))
    body))

;; (use-package :tag "")

(add-to-list 'use-package-keywords :tag)

(defun use-package-normalize/:tag (name keyword args)
  "Do nothing"
  nil)

(defun use-package-handler/:tag (name keyword arg rest state)
  "Do nothing"
  (let ((body (use-package-process-keywords name rest state)))
    body))


(provide '_use-package)
