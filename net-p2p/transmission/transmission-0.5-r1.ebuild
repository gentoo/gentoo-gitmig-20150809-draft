# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/transmission/transmission-0.5-r1.ebuild,v 1.1 2006/06/16 05:12:32 squinky86 Exp $

inherit eutils

MY_P=${PN/t/T}-${PV}

DESCRIPTION="Transmission is a free, lightweight BitTorrent client."
HOMEPAGE="http://transmission.m0k.org"
SRC_URI="http://download.m0k.org/transmission/files/${MY_P}.tar.gz"
LICENSE="MIT"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk ssl"

DEPEND=">=dev-util/jam-2.5
	sys-devel/gettext
	gtk? ( >=x11-libs/gtk+-2.6 )
	ssl? ( dev-libs/openssl )"

S="${WORKDIR}/${MY_P}"

src_compile() {
	econf $(use_enable ssl openssl) \
		$(use_enable gtk) || die "configure failed"
	jam
}

src_install() {
	dobin transmissioncli

	if use gtk ; then
		dobin gtk/transmission-gtk
		insinto /usr/share/applications/
		doins "${FILESDIR}"/transmission.desktop
		insinto /usr/share/pixmaps/
		doins "${FILESDIR}"/transmission.png
	fi
}
