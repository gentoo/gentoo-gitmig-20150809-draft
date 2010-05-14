# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/emacs-flim/emacs-flim-0.ebuild,v 1.1 2010/05/14 14:38:19 ulm Exp $

DESCRIPTION="Virtual for FLIM (library for message representation in Emacs)"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="alpha amd64 ppc sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""

DEPEND=""
RDEPEND="|| (
		app-emacs/flim
		app-emacs/limit
	)"
