# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nxesd/nxesd-1.5.0.ebuild,v 1.1 2006/04/30 17:46:18 stuart Exp $

inherit libtool eutils

DESCRIPTION="Modified esound server, used by nxclient"
HOMEPAGE="http://www.nomachine.com/"
SRC_URI="http://web04.nomachine.com/download/1.5.0/sources/$P-3.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="alsa debug ipv6 tcpd"

DEPEND=">=media-libs/audiofile-0.1.5
	alsa? ( >=media-libs/alsa-lib-0.5.10b )
	tcpd? ( >=sys-apps/tcp-wrappers-7.6-r2 )"

RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	epatch $FILESDIR/nxesd-1.5.0-remove-doc-building.patch
}

src_compile() {
	local myconf="--prefix=/usr/NX --sysconfdir=/etc/esd \
		$(use_enable ipv6) $(use_enable debug debugging) \
		$(use_enable alsa) $(use_with tcpd libwrap)"

	elibtoolize

	econf $myconf || die "Configure failed"
	emake || die "Make failed"
}

src_install() {
	into /usr/NX
	dobin nxesd
	dobin nxesddsp
}
