# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/gccxml/gccxml-0.6.0-r1.ebuild,v 1.6 2007/02/11 11:20:08 vapier Exp $

inherit versionator eutils
PVM="$(get_version_component_range 1-2)"
DESCRIPTION="XML output extension to GCC"
HOMEPAGE="http://www.gccxml.org/"
SRC_URI="http://www.gccxml.org/files/v${PVM}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm ia64 mips ppc s390 sh ~sparc x86"
IUSE=""

DEPEND="dev-util/cmake"
RDEPEND=""

MYBUILDDIR=${WORKDIR}/build
src_unpack() {
	mkdir ${MYBUILDDIR}
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/obstack.h.diff
}
src_compile() {
	cd ${MYBUILDDIR}
	cmake ../${P} -DCMAKE_INSTALL_PREFIX:PATH=/usr || die "cmake failed"
	emake || die "emake failed"
}

src_install() {
	cd ${MYBUILDDIR}
	make DESTDIR=${D} install || die
}
