# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cdstatus/cdstatus-0.94a.ebuild,v 1.5 2004/03/27 02:44:07 eradicator Exp $

inherit eutils

MY_P="cdstatus${PV}"
DESCRIPTION="Tool for diagnosing cdrom drive and digital data (audio) extraction"
HOMEPAGE="http://cdstatus.sourceforge.net/"
SRC_URI="mirror://sourceforge/cdstatus/${MY_P}.tar.gz"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/glibc"

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
	einfo ""
	einfo "Check /usr/share/doc/cdstatus-${PV} for help"
	einfo ""
}

