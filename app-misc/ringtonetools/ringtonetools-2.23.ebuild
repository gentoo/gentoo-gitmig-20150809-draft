# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/ringtonetools/ringtonetools-2.23.ebuild,v 1.1 2005/03/13 06:02:47 chriswhite Exp $

DESCRIPTION="Ringtone Tools is a program for creating ringtones and logos for mobile phones"
HOMEPAGE="http://ringtonetools.mikekohn.net/"
SRC_URI="http://downloads.mikekohn.net/ringtonetools/${P}.tar.gz"

LICENSE="ringtonetools"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	emake FLAGS="${CFLAGS}" || die
}

src_install() {
	dobin ringtonetools || die
	dodoc docs/*
	docinto samples
	dodoc samples/*
}
