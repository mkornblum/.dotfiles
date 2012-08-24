;;; LOAD PATH
(let ((default-directory "~/.emacs.d"))
  (normal-top-level-add-subdirs-to-load-path))

(load "~/.emacs.d/package.el")
(require 'package)
(add-to-list 'package-archives
             '("marmalade" .
               "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
             '("elpa" . "http://tromey.com/elpa/"))

(require 'color-theme-sanityinc-solarized)

(fset 'yes-or-no-p 'y-or-n-p)
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)
(setq-default indent-tabs-mode nil)

(setq standard-indent 2)

(tool-bar-mode 0)
(scroll-bar-mode 0)
(winner-mode 1)

(setq mac-option-key-is-meta nil)
(setq mac-command-key-is-meta t)
(setq mac-command-modifier 'meta)
(setq mac-option-modifier nil)

(defun yank-and-indent ()
  "Yank and then indent the newly formed region according to mode."
  (interactive)
  (yank)
  (indent-according-to-mode))

(defun untabify-all ()
  (interactive)
  (untabify (point-min) (point-max)))

(defun indent-buffer ()
  "Fix indentation on the entire buffer."
  (interactive)
  (save-excursion)
  (indent-region (point-min) (point-max)))

(defun rotate-windows ()
  "Rotate your windows"
  (interactive)
  (cond
   ((not (> (count-windows) 1))
    (message "You can't rotate a single window!"))
   (t
    (let ((i 1)
          (num-windows (count-windows)))
      (while  (< i num-windows)
        (let* ((w1 (elt (window-list) i))
               (w2 (elt (window-list) (+ (% i num-windows) 1)))
               (b1 (window-buffer w1))
               (b2 (window-buffer w2))
               (s1 (window-start w1))
               (s2 (window-start w2)))
          (set-window-buffer w1 b2)
          (set-window-buffer w2 b1)
          (set-window-start w1 s2)
          (set-window-start w2 s1)
          (setq i (1+ i))))))))

(defun auto-make-directory ()
  (let ((dir (file-name-directory (buffer-file-name))))
    (unless (file-readable-p dir)
      (make-directory dir t))))

;; experimental, to control split mania on larger displays
;; grabbed from http://stackoverflow.com/questions/1381794/too-many-split-screens-opening-in-emacs
(setq pop-up-windows nil)

(defun my-display-buffer-function (buf not-this-window)
  (if (and (not pop-up-frames)
           (one-window-p)
           (or not-this-window
               (not (eq (window-buffer (selected-window)) buf)))
           (> (frame-width) 162))
      (split-window-horizontally))
  ;; Note: Some modules sets `pop-up-windows' to t before calling
  ;; `display-buffer' -- Why, oh, why!
  (let ((display-buffer-function nil)
        (pop-up-windows nil))
    (display-buffer buf not-this-window)))

(setq display-buffer-function 'my-display-buffer-function)


(add-to-list 'auto-mode-alist '("\\.scss\\'" . css-mode)) ;; turn on css-mode for sass
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.rake\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.hamlbars\\'" . haml-mode))

;; Trailing whitespace is significant in Markdown, so don't mess with it
(defadvice delete-trailing-whitespace (around disable-in-markdown activate)
  (unless (eq major-mode 'markdown-mode)
    ad-do-it))

(add-hook 'find-file-hook 'delete-trailing-whitespace)
(add-hook 'find-file-hook 'untabify-all)
(add-hook 'before-save-hook 'delete-trailing-whitespace) ;; go to hell trailing whitespace
(add-hook 'before-save-hook 'untabify-all)
(add-hook 'before-save-hook 'auto-make-directory)

(require 'smex)
(require 'ido)
(require 'find-file-in-git-repo)
(require 'haml-mode)
(require 'feature-mode)
(require 'sass-mode)
(require 'scss-mode)
(require 'rspec-mode)
(require 'magit)
;; (require 'project)
(require 'simp)
(require 'multi-term)
;;(require 'emux)
(require 'midnight)

(simp-project-define
 '(:type rails
         :has (config.ru app/views app/models app/controllers)
         :ignore (tmp coverage log vendor .git public/system public/assets)))

(smex-initialize)
(ido-mode t)
(setq linum-format "%d")

(global-set-key (kbd "C-#") 'comment-region)
(global-set-key (kbd "C-@") 'uncomment-region)
(global-set-key (kbd "M-l")  'next-multiframe-window)
(global-set-key (kbd "M-h") 'previous-multiframe-window)
(global-set-key (kbd "C-c r") 'simp-project-rgrep)
(global-set-key (kbd "C-c d") 'make-directory)
(global-set-key (kbd "C-y") 'yank-and-indent)
(global-set-key (kbd "M-s s") 'replace-string)
(global-set-key (kbd "M-s S") 'replace-regexp)
(global-set-key (kbd "C-c R") 'simp-project-rgrep-thing-at-point)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-,") 'indent-buffer)
(global-set-key (kbd "C-S-r") 'rotate-windows)
(global-set-key (kbd "C-x g") 'magit-status)

(setq
 term-bind-key-alist
 '(("C-x c" . emux-terminal-create)
   ("C-x r" . emux-terminal-rename)
   ("C-x K" . emux-terminal-destroy)
   ("C-x C" . emux-screen-create)
   ("C-x R" . emux-screen-rename)
   ("C-x s" . emux-screen-switch)
   ("C-x M-s" . emux-jump-to-screen)
   ("C-x S" . emux-session-switch)
   ("C-x P" . emux-session-load-template)
   ("C-x C-S-k" . emux-session-destroy)
   ("C-x B" . emux-jump-to-buffer)
   ("C-S-y" . emux-terminal-yank)
   ("C-x -" . emux-terminal-vsplit)
   ("C-x |" . emux-terminal-hsplit)
   ("C-c C-c" . term-interrupt-subjob)
   ("C-S-c" . term-interrupt-subjob)
   ("C-S-p" . previous-line)
   ("C-S-s" . isearch-forward)
   ("C-S-r" . isearch-backward)
   ("C-m" . term-send-raw)
   ("M-f" . term-send-forward-word)
   ("M-b" . term-send-backward-word)
   ("M-o" . term-send-backspace)
   ("M-d" . term-send-forward-kill-word)
   ("C-r" . term-send-reverse-search-history)
   ("M-DEL" . term-send-backward-kill-word)
   ("M-," . term-send-input)
   ("M-." . comint-dynamic-complete)))



(emux-session-create '(:name "default"))
