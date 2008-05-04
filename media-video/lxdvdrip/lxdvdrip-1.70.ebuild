# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/lxdvdrip/lxdvdrip-1.70.ebuild,v 1.2 2008/05/04 14:16:06 drac Exp $

inherit eutils toolchain-funcs

DESCRIPTION="command line tool to automate the process of ripping and burning DVD"
SRC_URI="mirror://berlios/lxdvdrip/${P}.tgz"
HOMEPAGE="http://developer.berlios.de/projects/lxdvdrip/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""

DEPEND="media-libs/libdvdread
	media-libs/libdvdnav"
RDEPEND="${DEPEND}
	>=media-video/dvdauthor-0.6.9
	media-video/streamdvd
	media-video/mpgtx"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-makefile.patch"
	epatch "${FILESDIR}/${P}-vamps-makefile.patch"
}

src_compile() {
	CC=$(tc-getCC) emake || die "emake failed"
	cd "${S}/vamps"
	emake CC=$(tc-getCC) || die "emake lxdvdip vamps failed"
}

src_install () {
	dobin lxdvdrip
	dobin lxac3scan
	dodoc doc-pak/Changelog* doc-pak/Credits doc-pak/Debugging.*
	dodoc doc-pak/lxdvdrip.conf* doc-pak/README* doc-pak/TODO
	doman lxdvdrip.1

	insinto /usr/share
	doins lxdvdrip.wav

	insinto /etc
	newins doc-pak/lxdvdrip.conf.EN lxdvdrip.conf

	cd "${S}/vamps"
	emake PREFIX="${D}/usr" install || die "make install failed for vamps!"
}
