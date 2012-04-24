# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/librtas/librtas-1.3.6.ebuild,v 1.2 2012/04/24 19:43:57 ssuominen Exp $

EAPI=4
inherit eutils

DESCRIPTION=" Librtas provides a set of libraries for user-space access to RTAS on the ppc64 architecture."
HOMEPAGE="http://sourceforge.net/projects/librtas/"
SRC_URI="mirror://sourceforge/${P}.tar.gz"

LICENSE="IBM"
SLOT="0"
KEYWORDS="~ppc ~ppc64"
IUSE=""

DOCS="README"

src_prepare() { epatch "${FILESDIR}"/${P}-symlink.patch; }
