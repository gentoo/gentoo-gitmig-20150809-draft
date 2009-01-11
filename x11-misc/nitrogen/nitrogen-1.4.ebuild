# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/nitrogen/nitrogen-1.4.ebuild,v 1.4 2009/01/11 21:07:19 maekke Exp $

inherit eutils autotools

DESCRIPTION="GTK+ background browser and setter for X."
HOMEPAGE="http://projects.l3ib.org/nitrogen/"
SRC_URI="http://projects.l3ib.org/${PN}/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="xinerama"

RDEPEND=">=dev-cpp/gtkmm-2.10
	>=x11-libs/gtk+-2.10
	xinerama? ( x11-libs/libXinerama )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	xinerama? ( x11-proto/xineramaproto )"

src_unpack () {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/Makefile-as-needed.patch
	eautoreconf
}

src_compile() {
	econf $(use_enable xinerama) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
