# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/chillispot/chillispot-0.94.ebuild,v 1.3 2004/07/15 05:27:09 agriffis Exp $

inherit eutils flag-o-matic

DESCRIPTION="ChilliSpot is an open source captive portal or wireless LAN access point controller."
HOMEPAGE="http://www.chillispot.org"
SRC_URI="http://www.chillispot.org/download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~mips ~sparc"
IUSE="pic"

DEPEND="virtual/libc >=sys-apps/sed-4*"

src_unpack() {
	unpack ${A}
	cd ${S}/src
	epatch ${FILESDIR}/${P}-src.patch
}

src_compile() {
	local myconf
	export CFLAGS

	use pic && myconf="${myconf} --with-pic"

	econf ${myconf} || die "FAILED: econf ${myconf}"
	emake || die "FAILED: emake"
}

src_install() {
	einstall || die "einstall failed"
}
