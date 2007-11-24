# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/emacs/emacs-22.ebuild,v 1.18 2007/11/24 23:28:54 ulm Exp $

DESCRIPTION="Virtual for GNU Emacs"
HOMEPAGE="http://www.gentoo.org/proj/en/lisp/emacs/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ia64 ppc ppc64 sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND="|| (
		=app-editors/emacs-22*
		>=app-editors/emacs-cvs-22
	)"
