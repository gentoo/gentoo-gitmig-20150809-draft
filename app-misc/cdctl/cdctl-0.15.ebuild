# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/cdctl/cdctl-0.15.ebuild,v 1.13 2004/10/19 03:33:02 tgall Exp $

inherit eutils
EPATCH_SOURCE=${FILESDIR}

DESCRIPTION="Utility to control your cd/dvd drive"
HOMEPAGE="http://cdctl.sourceforge.net/"
SRC_URI="mirror://sourceforge/cdctl/${P}.tar.gz"

LICENSE="free-noncomm"
SLOT="0"
KEYWORDS="x86 ppc ~amd64 ppc64"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc NEWS NUTSANDBOLTS PUBLICKEY README
}
