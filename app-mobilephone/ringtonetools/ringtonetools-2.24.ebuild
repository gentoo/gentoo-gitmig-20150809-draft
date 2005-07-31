# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/ringtonetools/ringtonetools-2.24.ebuild,v 1.3 2005/07/31 21:05:33 dertobi123 Exp $

DESCRIPTION="Ringtone Tools is a program for creating ringtones and logos for mobile phones"
HOMEPAGE="http://ringtonetools.mikekohn.net/"
SRC_URI="http://downloads.mikekohn.net/ringtonetools/${P}.tar.gz"

LICENSE="ringtonetools"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	emake FLAGS="${CFLAGS}" || die "make failed"
}

src_install() {
	dobin ringtonetools
	dodoc docs/*
	docinto samples
	dodoc samples/*
}
