# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/mmdb/mmdb-1.0.8.3.ebuild,v 1.2 2010/02/02 19:17:56 jlec Exp $

inherit versionator

MY_PV=$(replace_version_separator 3 -ysbl-)
MY_P=${PN}-${MY_PV}

DESCRIPTION="The Coordinate Library is designed to assist CCP4 developers in working with coordinate files"
HOMEPAGE="http://www.ebi.ac.uk/~keb/cldoc/"
SRC_URI="http://www.ysbl.york.ac.uk/~emsley/software/${MY_P}.tar.gz"
LICENSE="ccp4"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
RDEPEND="!sci-biology/ncbi-tools++"
DEPEND="${RDEPEND}"
S=${WORKDIR}/${MY_P}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
