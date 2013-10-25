(add-to-list 'load-path "~/.emacs.d/site-lisp/region-bindings-mode")
(add-to-list 'load-path "~/.emacs.d/markdown-mode")

(require 'markdown-mode)
(setq auto-mode-alist (cons '("\\.md" . markdown-mode) auto-mode-alist))

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

;; Scala Mode 2
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)
(unless (package-installed-p 'scala-mode2)
  (package-refresh-contents) (package-install 'scala-mode2))

;; make emacs use the clipboard
(setq x-select-enable-clipboard t)

;; Allow to delete selection by default
(delete-selection-mode t)

;; Python Hook
(add-hook 'python-mode-hook
          (function (lambda ()
                      (setq indent-tabs-mode nil
                            tab-width 2))))

;; region bindings
(require 'region-bindings-mode)
(region-bindings-mode-enable)

;; Make with the curly options
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;; Rename buffer and file
;; source: http://steve.yegge.googlepages.com/my-dot-emacs-file
(defun rename-this (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
          (message "A buffer named '%s' already exists!" new-name)
        (progn
          (rename-file name new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil))))))

;; Up\Down paragraph
(global-set-key (kbd "M-p") 'backward-paragraph)
(global-set-key (kbd "M-n") 'forward-paragraph)

;; Goto line
(global-set-key (kbd "C-'") 'goto-line)

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

(put 'set-goal-column 'disabled nil)

(defun delete-this-buffer-and-file ()
  "Removes file connected to current buffer and kills buffer."
  (interactive)
  (let ((filename (buffer-file-name))
        (buffer (current-buffer))
        (name (buffer-name)))
    (if (not (and filename (file-exists-p filename)))
        (error "Buffer '%s' is not visiting a file!" name)
      (when (yes-or-no-p "Are you sure you want to remove this file? ")
        (delete-file filename)
        (kill-buffer buffer)
        (message "File '%s' successfully removed" filename)))))
(global-set-key (kbd "C-x K") 'delete-this-buffer-and-file)

