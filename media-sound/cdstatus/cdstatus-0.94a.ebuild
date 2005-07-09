# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cdstatus/cdstatus-0.94a.ebuild,v 1.11 2005/07/09 19:04:22 swegener Exp $

inherit eutils

MY_P="cdstatus${PV}"
DESCRIPTION="Tool for diagnosing cdrom drive and digital data (audio) extraction"
HOMEPAGE="http://cdstatus.sourceforge.net/"
SRC_URI="mirror://sourceforge/cdstatus/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
#-sparc -amd64: 0.94a: Generates bad wav files  x86 is good...
KEYWORDS="x86 -amd64 -sparc ~ppc64"
IUSE=""

DEPEND="virtual/libc"

S=${WORKDIR}/${MY_P}

src_compile() {
	epatch ${FILESDIR}/${P}-gentoo.diff
	make || die
}

src_install() {
	dobin cdstatus
	fperms 755 /usr/bin/cdstatus
	dodoc docs/*
}

pkg_postinst() {
	einfo
	einfo "Check /usr/share/doc/cdstatus-${PV} for help"
	einfo
}

