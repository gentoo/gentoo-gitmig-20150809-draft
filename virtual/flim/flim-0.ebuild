# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/flim/flim-0.ebuild,v 1.1 2007/05/15 09:54:51 ulm Exp $

DESCRIPTION="Virtual for flim (library for message representation in Emacs)"
HOMEPAGE="http://www.gentoo.org/proj/en/lisp/emacs/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ppc ppc-macos sparc x86"
IUSE=""

DEPEND=""
RDEPEND="|| (
	app-emacs/flim
	app-emacs/limit
	)"
