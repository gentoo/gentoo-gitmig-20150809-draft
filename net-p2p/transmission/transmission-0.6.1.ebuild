# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/transmission/transmission-0.6.1.ebuild,v 1.2 2006/08/15 23:58:18 squinky86 Exp $

inherit eutils

MY_PN="${PN/t/T}"
MY_P=${MY_PN}-${PV}

DESCRIPTION="a lightweight BitTorrent client"
HOMEPAGE="http://transmission.m0k.org/"
SRC_URI="http://download.m0k.org/transmission/files/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk ssl"

DEPEND="sys-devel/gettext
	gtk? ( >=x11-libs/gtk+-2.6 )
	ssl? ( dev-libs/openssl )"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-configure.patch
}

src_compile() {
	econf $(use_enable ssl openssl) \
		$(use_enable gtk) || die "configure failed"
	emake || die "make failed"
}

src_install() {
	dobin cli/transmissioncli

	if use gtk ; then
		dobin gtk/transmission-gtk

		doicon "${FILESDIR}/transmission.png"
		make_desktop_entry "transmission-gtk" "${MY_PN}" "${PN}.png" \
			"Network;Internet;GNOME;GTK;X-Red-Hat-Base"
	fi
	dodoc AUTHORS NEWS README
}
