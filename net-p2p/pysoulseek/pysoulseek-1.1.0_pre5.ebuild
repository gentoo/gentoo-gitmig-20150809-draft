# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/pysoulseek/pysoulseek-1.1.0_pre5.ebuild,v 1.1 2003/04/19 14:17:32 liquidx Exp $

IUSE="oggvorbis"

inherit eutils distutils

MY_PN="${PN/soulseek/slsk}"

# Hyriand Patch Version (skip first 3 version numbers)
# - disabled beacuse of _pre prefix
#MY_HV=${PV#*.*.*.}
MY_HV="1.4"

# Main pysoulseek Package-Version (remove trailing MY_HV)
# - disabled because of _pre, stripping _ from versioning
#MY_P=${MY_PN}-${PV%.${MY_HV}}
MY_P=${MY_PN}-${PV/_/}

DESCRIPTION="client for SoulSeek filesharing"
HOMEPAGE="http://www.sensi.org/~ak/pyslsk/ 
	http://thegraveyard.org/pyslsk/index.html"
SRC_URI="http://www.sensi.org/~ak/pyslsk/${MY_P}.tar.gz 
	http://thegraveyard.org/pyslsk/${MY_P}-hyriand-${MY_HV}.patch"

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
	epatch ${DISTDIR}/${MY_P}-hyriand-${MY_HV}.patch
}
