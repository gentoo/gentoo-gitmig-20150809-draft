# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdbakeoven/cdbakeoven-2.0_beta2.ebuild,v 1.15 2004/07/06 12:41:28 carlo Exp $

inherit eutils kde

MY_P=${P/_/}
S=${WORKDIR}/${MY_P}

DESCRIPTION="CDBakeOven, KDE CD Writing Software"
HOMEPAGE="http://cdbakeoven.sourceforge.net/"
SRC_URI="mirror://sourceforge/cdbakeoven/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="-*"
IUSE=""

DEPEND=">=media-libs/libogg-1.0_rc2
	virtual/mpg123
	>=media-sound/cdparanoia-3.9.8
	>=app-cdr/cdrtools-1.11
	>=kde-base/kdemultimedia-3.1.1"
RDEPEND=${DEPEND}
need-kde 3

src_unpack() {
	unpack ${A} || die
	cd ${S}
	epatch ${FILESDIR}/configure-2.0_beta2.patch
	epatch ${FILESDIR}/acinclude.m4-2.0_beta2.patch
}
