# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/transmission/transmission-0.6.1-r1.ebuild,v 1.7 2007/05/07 17:20:24 dertobi123 Exp $

inherit eutils

MY_PN="Transmission"

DESCRIPTION="Simple BitTorrent client"
HOMEPAGE="http://transmission.m0k.org/"
SRC_URI="http://download.m0k.org/transmission/files/${MY_PN}-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="gtk"

RDEPEND="sys-devel/gettext
		 dev-libs/openssl
		 gtk? ( >=x11-libs/gtk+-2.6 )"
DEPEND="${RDEPEND}
		sys-devel/gettext
		>=dev-util/pkgconfig-0.19"

S="${WORKDIR}/${MY_PN}-${PV}"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${PN}-0.6.1-gtk+-check.patch
	epatch ${FILESDIR}/${PN}-0.6.1-as-needed.patch

	# Fix man page install location
	sed -i -e 's|/man/man1|/share/man/man1|' mk/common.mk
}

src_compile() {
	econf $(use_enable gtk) || die "configure failed"
	emake || die "build failed"
}

src_install() {
	make PREFIX="${D}/usr" LOCALEDIR="\$(PREFIX)/share/locale" install \
		|| die "install failed"

	if use gtk ; then
		doicon "${FILESDIR}/transmission.png"
		make_desktop_entry "transmission-gtk" "${PN}" "${PN}.png" \
			"Network;Internet;P2P"
	fi

	dodoc AUTHORS NEWS README
}
