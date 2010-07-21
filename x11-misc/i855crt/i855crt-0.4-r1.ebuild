# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/i855crt/i855crt-0.4-r1.ebuild,v 1.2 2010/07/21 14:41:33 ssuominen Exp $

inherit eutils

DESCRIPTION="Intel Montara 855GM CRT out auxiliary driver"
HOMEPAGE="http://i855crt.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="x11-libs/libXext
	x11-libs/libXv"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-i915support.diff

	# upstream ships it with the binary, we want to make sure we compile it
	make clean || die
}

src_install() {
	dobin i855crt || die
	insinto /etc
	doins i855crt.conf || die
}
