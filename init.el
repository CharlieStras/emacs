(setq inhibit-startup-message t)
(scroll-bar-mode 0)  ; Disable visible scrollbar
(tool-bar-mode 0)    ; Disable the toolbar
(tooltip-mode 0)     ; Disable tooltips
(menu-bar-mode 0)    ; Disable the menu bar

(load-theme 'night-owl t)

(setq fonts
      (cond ((eq system-type 'darwin)     '("Dank Mono" "STHeiti"))
            ((eq system-type 'gnu/linux)  '("Menlo"     "WenQuanYi Zen Hei"))
            ((eq system-type 'windows-nt) '("Consolas"  "Microsoft Yahei"))))
(set-face-attribute 'default
		    nil
		    :font
                    (format "%s:pixelsize=%d" (car fonts) 18))
(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font (frame-parameter nil 'font) charset
                    (font-spec :family (car (cdr fonts)))))
;; Fix chinese font width and rescale
(setq face-font-rescale-alist '(("Microsoft Yahei" . 1.15) ("WenQuanYi Micro Hei Mono" . 1.15) ("STHeiti". 1.15)))

(setq url-proxy-services
   '(("http" . "127.0.0.1:12639")
     ("https" . "127.0.0.1:12639")))

(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning: 
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  (add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (add-to-list 'package-archives (cons "org" (concat proto "://orgmode.org/elpa/")) t)
  (add-to-list 'package-archives (cons "elpa" (concat proto "://elpa.gnu.org/packages/")) t)
  )
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))

(setq exec-path (append exec-path '("/usr/local/bin")))

(ido-mode 1)
(setq ido-everywhere t)
(setq ido-enable-flex-matching t)

(global-set-key [remap dabbrev-expand] 'hippie-expand)
