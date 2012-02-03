# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/oroborus/oroborus-2.0.20.ebuild,v 1.3 2012/02/03 22:37:13 ranger Exp $

DESCRIPTION="Small and fast window manager."
HOMEPAGE="http://www.oroborus.org"
SRC_URI="http://ftp.debian.org/debian/pool/main/o/${PN}/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc ~x86"
IUSE="gnome"

RDEPEND="x11-libs/libXpm
	x11-libs/libXext
	x11-libs/libSM
	x11-libs/libICE
	x11-libs/libX11"
DEPEND="${RDEPEND}
	x11-proto/xproto
	x11-proto/xextproto"

src_compile() {
	econf --disable-dependency-tracking
	emake || die "emake failed."
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed."

	if use gnome; then
		insinto /usr/share/gnome/wm-properties
		doins "${FILESDIR}"/${PN}.desktop
	fi

	dodoc AUTHORS ChangeLog example.${PN}rc README TODO || die
}
