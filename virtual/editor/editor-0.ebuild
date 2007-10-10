# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/editor/editor-0.ebuild,v 1.1 2007/10/10 06:03:22 opfer Exp $

DESCRIPTION="Virtual for editor"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 ppc-macos s390 sh sparc ~sparc-fbsd x86 ~x86-fbsd"
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
	app-editors/le
	app-editors/mg
	app-editors/ne
	app-editors/ng
	app-editors/nvi
	app-editors/pico
	app-editors/qemacs
	app-editors/teco
	app-editors/uemacs-pk
	app-editors/vile
	app-editors/vim
	app-editors/zile
	app-editors/xemacs
	app-misc/mc
	dev-scheme/mit-scheme
	sys-apps/ed )"

