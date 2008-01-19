# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmblob/wmblob-1.0.3.ebuild,v 1.1 2008/01/19 14:47:31 drac Exp $

DESCRIPTION="a fancy but useless dockapp with moving blobs."
HOMEPAGE="http://freshmeat.net/projects/wmblob"
SRC_URI="mirror://debian/pool/main/w/${PN}/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2
	x11-libs/libX11
	x11-libs/libXpm
	x11-libs/libXext"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	x11-proto/xextproto
	x11-libs/libXt"

src_unpack() {
	unpack ${A}
	sed -i -e "s:-O2:${CFLAGS}:g" "${S}"/configure
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README doc/how_it_works
}
