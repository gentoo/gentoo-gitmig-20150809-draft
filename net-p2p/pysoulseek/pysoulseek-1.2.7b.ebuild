# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/pysoulseek/pysoulseek-1.2.7b.ebuild,v 1.6 2006/02/07 20:52:31 blubb Exp $

inherit eutils distutils

IUSE="vorbis"
MY_PN="${PN/soulseek/slsk}"

MY_P=${MY_PN}-${PV}

DESCRIPTION="client for SoulSeek filesharing"
HOMEPAGE="http://www.sensi.org/~ak/pyslsk/
	http://thegraveyard.org/pyslsk/index.html"
SRC_URI="http://www.sensi.org/~ak/pyslsk/${MY_P}.tar.gz "

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ppc sparc x86"

DEPEND=">=dev-lang/python-2.1
	=dev-python/wxpython-2.6*
	vorbis? ( dev-python/pyvorbis dev-python/pyogg )"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-multislot.patch
}

src_install() {
	distutils_src_install
	insinto /usr/share/applications
	doins ${FILESDIR}/pysoulseek.desktop
}

pkg_postinst() {
	echo
	einfo "The hydriant patch no longer is, checkout net-p2p/nicotine from the same people"
	echo
}
