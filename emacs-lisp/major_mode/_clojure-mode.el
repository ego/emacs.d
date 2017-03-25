;; Clojure

(defun my-clojure-mode()
  (message "Loaded my-clojure-mode"))


(use-package cider
	:doc "http://cider.readthedocs.io/en/latest/installation/"
	:tag "Cider"
	:init 
	(setq cider-repl-use-pretty-printing   t
		  cider-repl-use-clojure-font-lock t
		  cider-repl-result-prefix ";; => "
		  ;; cider-repl-scroll-on-output f  ;; error here!
		  cider-repl-wrap-history t
		  cider-repl-history-size 3000
		  cider-show-error-buffer nil)
	:config
	(add-to-list 'package-pinned-packages '(cider . "melpa-stable") t)
	(add-hook 'cider-mode-hook      #'eldoc-mode)
	(add-hook 'cider-repl-mode-hook #'company-mode)
	(add-hook 'cider-mode-hook      #'company-mode)
	;; Auto-completion
	(add-hook 'cider-repl-mode-hook #'company-mode)
	(add-hook 'cider-mode-hook #'company-mode))

(use-package clj-refactor
    :doc "clj-refactor"
    :init
    (setq cljr-auto-sort-ns nil
    	  cljr-favor-prefix-notation nil)
    :config
    (add-hook 'clojure-mode-hook
	  (lambda ()
	    (clj-refactor-mode 1)
	    ;; insert keybinding setup here
		(cljr-add-keybindings-with-prefix "C-c RET")))
	(add-hook 'clojure-mode-hook #'yas-minor-mode))

(use-package let-alist :doc "let-alist")

(use-package flycheck-clojure :doc "flycheck-clojure")

(use-package flycheck
    :doc "flycheck"
    :config
    (eval-after-load 'flycheck '(flycheck-clojure-setup))
    (add-hook 'after-init-hook #'global-flycheck-mode))

(use-package clojure-mode
	:init 
	(setq clojure-indent-style :always-indent)
	:config
	(defun set-newline-and-indent ()
	  (local-set-key (kbd "RET") 'newline-and-indent))
	(add-hook 'lisp-mode-hook 'set-newline-and-indent)

	;; (require 'clojure-mode-extra-font-locking)

	(add-hook 'clojure-mode-hook #'subword-mode)
	(add-hook 'clojure-mode-hook #'paredit-mode)
	(add-hook 'clojure-mode-hook #'aggressive-indent-mode))

(use-package clojure-snippets :defer t)


;; https://wavesurfer-js.org/blog/ido-at-point.html
;; http://xiaohanyu.me/oh-my-emacs/core/ome-completion.html
;; http://company-mode.github.io/
;; company-indent-or-complete-common
