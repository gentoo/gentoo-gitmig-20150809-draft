# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/liboil/liboil-0.3.1.ebuild,v 1.1 2005/03/18 17:50:13 rizzo Exp $

inherit eutils
DESCRIPTION="Liboil is a library of simple functions that are optimized for various CPUs."
HOMEPAGE="http://www.schleef.org/liboil/"
SRC_URI="http://www.schleef.org/${PN}/download/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
IUSE=""
#RESTRICT="nostrip"
DEPEND="=dev-libs/glib-2*"
#RDEPEND=""
#S=${WORKDIR}/${P}

src_compile() {
	econf || die "econf failed"
	MAKEOPTS="${MAKEOPTS} -j1" emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die
}
