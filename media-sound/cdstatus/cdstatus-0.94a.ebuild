# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cdstatus/cdstatus-0.94a.ebuild,v 1.4 2004/03/01 05:37:13 eradicator Exp $

MY_P="cdstatus${PV}"
DESCRIPTION="Tool for diagnosing cdrom drive and digital data (audio) extraction"
HOMEPAGE="http://cdstatus.sourceforge.net/"
SRC_URI="mirror://sourceforge/cdstatus/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/glibc"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

src_compile() {

	epatch ${FILESDIR}/${P}-gentoo.diff
	make || die
}

src_install() {
	into /usr
	dobin cdstatus
	fperms 755 /usr/bin/cdstatus
	dodoc docs/*
}

pkg_postinst() {
	einfo ""
	einfo "Check /usr/share/doc/cdstatus-${PV} for help"
	einfo ""
}

