# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-antivirus/klamav/klamav-0.09.4.ebuild,v 1.3 2005/03/19 20:43:47 blubb Exp $

inherit eutils kde

IUSE="arts doc"

DESCRIPTION="KDE frontend for ClamAV"
HOMEPAGE="http://klamav.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~amd64"

DEPEND="app-antivirus/clamav"
need-kde 3

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${PN}-desktop_polish.patch
}

