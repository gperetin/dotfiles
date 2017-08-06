(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (evil popup-imenu counsel ivy fzf projectile which-key ensime use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; My config

;; global variables
(setq
 inhibit-startup-screen t
 create-lockfiles nil
 make-backup-files nil
 column-number-mode t
 scroll-error-top-bottom t
 show-paren-delay 0.5
 use-package-always-ensure t
 sentence-end-double-space nil)

;; buffer local variables
(setq-default
 indent-tabs-mode nil
 tab-width 4
 c-basic-offset 4)

;; Automatically indent after RET
(electric-indent-mode +1)

;; global keybindings
(global-unset-key (kbd "C-z"))

;; the package manager
(require 'package)
(setq
 package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                    ("org" . "http://orgmode.org/elpa/")
                    ("melpa" . "http://melpa.org/packages/")
                    ("melpa-stable" . "http://stable.melpa.org/packages/"))
 package-archive-priorities '(("melpa-stable" . 1)))

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)

(use-package evil
  :ensure t
  :config
  (evil-mode 1))

(use-package ensime
  :ensure t
  :pin melpa)

(use-package sbt-mode
  :pin melpa)

(use-package scala-mode
  :pin melpa)

; (setq default-frame-alist '((font . "Iosevka Term-18")))
(setq default-frame-alist '((font . "Source Code Pro-18")))

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(blink-cursor-mode 0)

(show-paren-mode)

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

(defalias 'list-buffers 'ibuffer)

; Which key
(which-key-mode)

; Disable all bells
(setq ring-bell-function 'ignore)

; Projectile
(use-package projectile
  :ensure t
  :config
  (projectile-mode 1))

(setq projectile-enable-caching t)

; Swiper, counsel and ivy
(use-package counsel
  :ensure t)

(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq ivy-count-format "(%d/%d) ")

; Fzf
(use-package fzf
  :ensure t)

; Tune GC
(defun my-minibuffer-setup-hook ()
  (setq gc-cons-threshold most-positive-fixnum))

(defun my-minibuffer-exit-hook ()
  (setq gc-cons-threshold 8000000))

(add-hook 'minibuffer-setup-hook #'my-minibuffer-setup-hook)
(add-hook 'minibuffer-exit-hook #'my-minibuffer-exit-hook)

; Showing git branch in modeline on file open is slow, let's remove that hook
(remove-hook 'find-file-hook 'vc-refresh-state)

; Faster fuzzy file search
(define-key evil-normal-state-map ",f" 'counsel-git)

;; Rust config
(use-package rust-mode
  :ensure t)
