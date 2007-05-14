# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/uptimes/uptimes-2.3.ebuild,v 1.13 2007/05/14 20:54:16 ulm Exp $

inherit elisp

DESCRIPTION="Track and display emacs session uptimes"
HOMEPAGE="http://www.davep.org/emacs/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ppc64 x86"
IUSE=""

SITEFILE=50${PN}-gentoo.el
