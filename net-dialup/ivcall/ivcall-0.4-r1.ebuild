# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/ivcall/ivcall-0.4-r1.ebuild,v 1.1 2005/04/06 05:26:11 mrness Exp $

inherit eutils

DESCRIPTION="Utility for making automated telephone calls via ISDN"
HOMEPAGE="http://0pointer.de/lennart/projects/ivcall/"
SRC_URI="http://0pointer.de/lennart/projects/ivcall/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="softfax"
DEPEND="net-dialup/isdn4k-utils
	softfax? ( >=media-libs/spandsp-0.0.2_pre10 )"

src_compile() {
	local myconf="--disable-lynx --disable-xmltoman"
	econf $myconf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"
	dohtml doc/*.{html,css}
	dodoc doc/README
}
