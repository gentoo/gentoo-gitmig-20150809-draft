# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/pysoulseek/pysoulseek-1.2.0-r1.ebuild,v 1.1 2003/05/28 22:41:59 vladimir Exp $

IUSE="oggvorbis hyriand"

inherit eutils distutils

MY_PN="${PN/soulseek/slsk}"
MY_PV="${PV/_/}"

#MY_HV=${PV#*.*.*.}
MY_HV=4

MY_P=${MY_PN}-${MY_PV%.${MY_HV}}

DESCRIPTION="client for SoulSeek filesharing"
HOMEPAGE="http://www.sensi.org/~ak/pyslsk/ 
	http://thegraveyard.org/pyslsk/index.html"
SRC_URI="http://www.sensi.org/~ak/pyslsk/${MY_P}.tar.gz 
	hyriand?  ( http://thegraveyard.org/pyslsk/${MY_P}-hyriand-${MY_HV}.patch )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"

DEPEND=">=dev-lang/python-2.1
	>=dev-python/wxPython-2.4.0.1
	~x11-libs/wxGTK-2.4.0
	oggvorbis? ( media-libs/pyvorbis media-libs/pyogg )"

RDEPEND=${DEPEND}

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${MY_P}.tar.gz
	use hyriand && epatch ${DISTDIR}/${MY_P}-hyriand-${MY_HV}.patch
}

pkg_postinst() {
	echo
	einfo "Use of the hyriand patch is now dependent on a local USE flag"
	einfo "If you want the hyriand features, add 'hyriand' to your USE flags"
	echo
}
