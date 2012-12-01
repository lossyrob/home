;; ensime
(add-to-list 'load-path "~/.emacs.d/site-lisp/multiple-cursors")
(add-to-list 'load-path "~/.emacs.d/site-lisp/region-bindings-mode")

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
'(inhibit-startup-screen t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

;; make emacs use the clipboard
(setq x-select-enable-clipboard t)

;; Allow to delete selection by default
(delete-selection-mode t)

;; region bindings
(require 'region-bindings-mode)
(region-bindings-mode-enable)

;; Make with the curly options
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;; multiple-cursors
(require 'multiple-cursors)
(define-key region-bindings-mode-map "a" 'mc/mark-all-like-this)
(define-key region-bindings-mode-map "p" 'mc/mark-previous-like-this)
(define-key region-bindings-mode-map "n" 'mc/mark-next-like-this)
(define-key region-bindings-mode-map "m" 'mc/mark-more-like-this-extended)

;; Up\Down paragraph
(global-set-key (kbd "M-p") 'backward-paragraph)
(global-set-key (kbd "M-n") 'forward-paragraph)

;; Use a better buffer switcher
(global-set-key (kbd "C-x C-b") 'ibuffer)

(global-set-key (kbd "C-c C-l e") 'erc-buffers)
(global-set-key (kbd "C-c C-l t") 'term-buffers)

(defun erc-buffers ()
  (interactive)
  (list-buffers-with-mode 'erc-mode))

(defun term-buffers ()
  (interactive)
  (list-buffers-with-mode 'term-mode))

(defun list-buffers-with-mode (mode)
  (interactive "SBuffer Mode: ")
  (progn
    (ibuffer-bs-show)
    (ibuffer-filter-disable)
    (ibuffer-filter-by-used-mode mode)))

;; Take out menu bar

(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)

;; Never write "\t" characters
(setq-default indent-tabs-mode nil)