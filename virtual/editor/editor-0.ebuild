# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/editor/editor-0.ebuild,v 1.5 2007/10/10 18:34:47 grobian Exp $

DESCRIPTION="Virtual for editor"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND="|| ( app-editors/nano
	app-editors/e3
	app-editors/easyedit
	app-editors/elvis
	app-editors/emacs
	app-editors/emacs-cvs
	app-editors/emact
	app-editors/ersatz-emacs
	app-editors/fe
	app-editors/gvim
	app-editors/jasspa-microemacs
	app-editors/jed
	app-editors/joe
	app-editors/jove
	app-editors/le
	app-editors/mg
	app-editors/ne
	app-editors/ng
	app-editors/nvi
	app-editors/qemacs
	app-editors/teco
	app-editors/uemacs-pk
	app-editors/vile
	app-editors/vim
	app-editors/xemacs
	app-editors/zile
	app-misc/mc
	dev-lisp/cmucl
	dev-scheme/mit-scheme
	sys-apps/ed )"
