# Copyright 2003 Matt Tucker <tuck@whistlingfish.net>
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/cdctl/cdctl-0.15.ebuild,v 1.4 2003/04/25 14:46:46 vapier Exp $

inherit eutils
EPATCH_SOURCE=${FILESDIR}

DESCRIPTION="Utility to control your cd/dvd drive"
SRC_URI="mirror://sourceforge/cdctl/${P}.tar.gz"
HOMEPAGE="http://cdctl.sourceforge.net/"

KEYWORDS="x86 ~ppc"
SLOT="0"
LICENSE="free-noncomm"

DEPEND="virtual/glibc"

src_unpack() { 
	unpack ${A}
	cd ${S}
	epatch
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc NEWS NUTSANDBOLTS LICENSE PUBLICKEY README
}
