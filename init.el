(when window-system
  (progn
    ;(set-frame-size (selected-frame) 160 58)
    (setq initial-frame-alist '((width . 160) (height . 58)))
    (setq default-frame-alist '((width . 160) (height . 58)))
    ))


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq make-backup-files nil)

(recentf-mode 1)
(setq-default recent-save-file "~/.emacs.d/recentf")

(load "~/.emacs.d/init-packages")

(load-theme 'gruvbox-dark-soft t)

(require 'evil)
(evil-mode 1)
(setq evil-emacs-state-cursor '("red" box))
(setq evil-normal-state-cursor '("orange" box))
(setq evil-visual-state-cursor '("brown" box))
(setq evil-insert-state-cursor '("red" bar))
(setq evil-replace-state-cursor '("red" bar))
(setq evil-operator-state-cursor '("red" hollow))
(setq evil-move-cursor-back nil)

(require 'helm)

(require 'helm-projectile)
(helm-projectile-on)

(require 'evil-leader)
(global-evil-leader-mode)

(require 'evil-magit)

(ac-config-default)
(global-auto-complete-mode t)

(require 'powerline)
(powerline-evil-vim-color-theme)
(display-time-mode t)
;; keybindings

(global-set-key (kbd "M-x") 'helm-M-x)

(evil-leader/set-leader "<SPC>")
(evil-leader/set-key
  "<SPC>" 'helm-M-x
  "b" 'helm-mini
  "f" 'helm-find-files
  "y" 'helm-show-kill-ring
  "r" 'helm-recentf
  "p" 'helm-projectile
  "P" 'helm-projectile-switch-project
  "j" 'helm-semantic-or-imenu
  "gs" 'magit-status
  "wo" 'delete-other-windows
  "wd" 'delete-window
  "qq" 'save-buffers-kill-emacs
  )

(require 'helm-descbinds)
(helm-descbinds-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
