# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mpdas/mpdas-0.2.2.ebuild,v 1.1 2008/11/24 00:14:10 yngwin Exp $

DESCRIPTION="An AudioScrobbler client for MPD written in C++"
HOMEPAGE="http://50hz.ws/mpdas/"
SRC_URI="http://50hz.ws/mpdas/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="media-libs/libmpd
	net-misc/curl"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	dobin ${PN} || die "dobin failed"
	dodoc README
}

pkg_postinst() {
	elog "For further configuration help consult the README in"
	elog "/usr/share/doc/${PF}/"
}
