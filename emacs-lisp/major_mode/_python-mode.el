(defun my-python-mode()
  (message "Loaded my-python-mode"))


 (use-package company
  :demand t
  ; :bind (("C-." . company-complete))
  ; :diminish company-mode
  :config (add-hook 'prog-mode-hook 'company-mode))


(use-package anaconda-mode
  :ensure t
  :diminish anaconda-mode
  ; :config (bind-key "M-," #'anaconda-nav-pop-marker anaconda-mode-map)
  )


(use-package company-anaconda
  :ensure t
  :init (add-to-list 'company-backends 'company-anaconda))


(add-hook 'python-mode-hook 'anaconda-mode 'anaconda-eldoc-mode)


;; https://github.com/jorgenschaefer/elpy
;; https://emacswiki.org/emacs/PythonProgrammingInEmacs
;; https://realpython.com/blog/python/emacs-the-best-python-editor/
;; https://github.com/purcell/emacs.d/search?utf8=%E2%9C%93&q=python
;; https://github.com/technomancy/emacs-starter-kit
;; https://github.com/syl20bnr/spacemacs/tree/master/layers/%2Blang/python
;; https://github.com/bbatsov/prelude/blob/f5f4d773f301dd80d0551055f6e3efdb0b5390b2/modules/prelude-python.el
