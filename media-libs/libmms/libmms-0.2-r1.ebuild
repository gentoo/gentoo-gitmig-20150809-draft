# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmms/libmms-0.2-r1.ebuild,v 1.1 2006/07/20 14:23:51 allanonjl Exp $

inherit eutils

DESCRIPTION="Common library for accessing Microsoft Media Server (MMS) media streaming protocol"

HOMEPAGE="http://libmms.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="LGPL-2.1"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack "${A}"
	cd "${S}"

	# patch for bug #139320
	epatch "${FILESDIR}"/${PN}_0.2-7-cumulative.diff
}

src_compile() {

	econf || die
	emake || die "emake failed"

}

src_install() {

	make DESTDIR=${D} install || die

	dodoc AUTHORS ChangeLog NEWS README* TODO

}
