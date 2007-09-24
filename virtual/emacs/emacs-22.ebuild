# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/emacs/emacs-22.ebuild,v 1.13 2007/09/24 11:38:32 armin76 Exp $

DESCRIPTION="Virtual for GNU Emacs"
HOMEPAGE="http://www.gentoo.org/proj/en/lisp/emacs/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ppc ~ppc64 sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND="|| (
			=app-editors/emacs-22*
			>=app-editors/emacs-cvs-22
		)"
