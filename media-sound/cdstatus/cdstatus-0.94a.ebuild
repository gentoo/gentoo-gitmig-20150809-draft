# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cdstatus/cdstatus-0.94a.ebuild,v 1.14 2007/01/05 17:26:14 flameeyes Exp $

inherit eutils

MY_P="cdstatus${PV}"
DESCRIPTION="Tool for diagnosing cdrom drive and digital data (audio) extraction"
HOMEPAGE="http://cdstatus.sourceforge.net/"
SRC_URI="mirror://sourceforge/cdstatus/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
#-sparc -amd64: 0.94a: Generates bad wav files  x86 is good...
KEYWORDS="-amd64 ppc64 -sparc x86"
IUSE=""

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
	elog
	elog "Check /usr/share/doc/cdstatus-${PV} for help"
	elog
}

