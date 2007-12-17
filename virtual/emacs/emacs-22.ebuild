# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/emacs/emacs-22.ebuild,v 1.20 2007/12/17 07:37:59 ulm Exp $

DESCRIPTION="Virtual for GNU Emacs"
HOMEPAGE="http://www.gentoo.org/proj/en/lisp/emacs/"
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND="|| (
		=app-editors/emacs-22*
		>=app-editors/emacs-cvs-22
	)"
