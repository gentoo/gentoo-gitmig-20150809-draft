# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/camsource/camsource-0.7.1.ebuild,v 1.6 2010/12/10 14:59:27 flameeyes Exp $

inherit eutils flag-o-matic autotools

DESCRIPTION="Unofficial release of Camsource, grabs images from a v4l and v4l2 webcam devices."
HOMEPAGE="http://koti.mbnet.fi/~turja/vino"
SRC_URI="http://koti.mbnet.fi/~turja/vino/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc sparc x86"
IUSE=""

RDEPEND=">=dev-libs/libxml2-2.4.22
	>=media-libs/jpeg-6b"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-example.patch

	eautoreconf
	filter-ldflags -Wl,-z,now
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog README
	newinitd "${FILESDIR}"/${PN}.initd ${PN}
	insinto /etc
	doins ${PN}.conf.example
	exeinto /usr/share/${PN}
	doexe scripts/camsource2bmp.pl
}

pkg_postinst() {
	elog
	elog "Edit /etc/camsource.conf.example config to your liking."
	elog
}
