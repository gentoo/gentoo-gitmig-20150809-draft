# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyifp/pyifp-0.2.2.ebuild,v 1.4 2009/05/10 16:42:18 ssuominen Exp $

inherit eutils distutils

DESCRIPTION="Python bindings for libifp library for accessing iRiver iFP devices"
HOMEPAGE="http://ifp-gnome.sourceforge.net"
SRC_URI="mirror://sourceforge/ifp-gnome/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE=""

RDEPEND="dev-lang/python
	>=media-libs/libifp-1.0.0.2"
DEPEND="${RDEPEND}
	dev-lang/swig"

DOCS="AUTHORS ChangeLog NEWS README"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-setup-fix.patch
}
