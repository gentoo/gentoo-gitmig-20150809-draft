# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nxproxy/nxproxy-1.4.0-r2.ebuild,v 1.4 2006/01/11 04:42:52 weeve Exp $

MY_P="${PN}-${PV}-2"
DESCRIPTION="X11 protocol compression library wrapper"
HOMEPAGE="http://www.nomachine.com/"
URI_BASE="http://www.nomachine.com/download/nxsources/"
SRC_NXPROXY="${MY_P}.tar.gz"
SRC_URI="$URI_BASE/nxproxy/${SRC_NXPROXY}"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~sparc x86"
IUSE=""
DEPEND="=net-misc/nx-x11-1.4*
	sys-devel/patch
	>=media-libs/jpeg-6b-r3
	>=sys-libs/glibc-2.3.2-r1
	>=sys-libs/zlib-1.1.4-r1"

# Run-time dependencies, same as DEPEND if RDEPEND isn't defined:
#RDEPEND=""

S=${WORKDIR}/${PN}

src_compile() {
	./configure

	emake || die "compile problem"
}

src_install() {
	exeinto /usr/NX/bin
	doexe nxproxy

	dodoc README README-IPAQ README-VALGRIND VERSION LICENSE
}
