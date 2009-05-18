# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmtp/libmtp-0.2.6.1.ebuild,v 1.9 2009/05/18 21:38:45 ssuominen Exp $

EAPI=2
inherit eutils

DESCRIPTION="An implementation of Microsoft's Media Transfer Protocol (MTP)."
HOMEPAGE="http://libmtp.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 hppa ppc ppc64 sparc x86"
IUSE="doc"

# Please don't delete this ebuild before I know if pympd
# work with 0.3.x versions, thanks, ssuominen.
RDEPEND="virtual/libusb"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

src_configure() {
	epatch "${FILESDIR}"/${P}-deprecated-keys.patch
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README TODO

	insinto /etc/udev/rules.d
	newins libmtp.rules 65-mtp.rules

	insinto /usr/share/hal/fdi/information/20thirdparty
	newins libmtp.fdi 10-libmtp.fdi
}
