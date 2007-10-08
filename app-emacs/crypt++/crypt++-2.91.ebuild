# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/crypt++/crypt++-2.91.ebuild,v 1.10 2007/10/08 19:35:29 ulm Exp $

inherit elisp

DESCRIPTION="Handle all sorts of compressed and encrypted files"
HOMEPAGE="http://freshmeat.net/projects/crypt/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86"
IUSE=""

SITEFILE=50${PN}-gentoo.el
