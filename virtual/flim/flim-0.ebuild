# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/flim/flim-0.ebuild,v 1.3 2007/10/15 22:03:47 opfer Exp $

DESCRIPTION="Virtual for flim (library for message representation in Emacs)"
HOMEPAGE="http://www.gentoo.org/proj/en/lisp/emacs/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc sparc x86"
IUSE=""

DEPEND=""
RDEPEND="|| (
		app-emacs/flim
		app-emacs/limit
	)"
