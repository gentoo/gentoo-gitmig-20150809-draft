# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyifp/pyifp-0.2.2.ebuild,v 1.3 2006/04/01 15:23:01 agriffis Exp $

inherit eutils distutils

DESCRIPTION="Python bindings for libifp library for accessing iRiver iFP devices"
HOMEPAGE="http://ifp-gnome.sourceforge.net"
SRC_URI="mirror://sourceforge/ifp-gnome/${P}.tar.gz"

KEYWORDS="~amd64 ~ia64 ~x86"

IUSE=""
LICENSE="LGPL-2"
SLOT="0"

DEPEND="dev-lang/python
	dev-lang/swig
	>=media-libs/libifp-1.0.0.2"

DOCS="AUTHORS COPYING ChangeLog NEWS README"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-setup-fix.patch
}
