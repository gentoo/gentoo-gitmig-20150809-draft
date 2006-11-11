# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdrkit/cdrkit-1.0_pre5.ebuild,v 1.1 2006/11/11 02:31:48 pylon Exp $

inherit eutils toolchain-funcs

MY_P="${PN}-${PV/_/}"

DESCRIPTION="Cdrkit is a fork of the latest complete free cdrtools sources."
HOMEPAGE="http://debburn.alioth.debian.org/"
SRC_URI="http://debburn.alioth.debian.org/${MY_P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="virtual/libc
	>=dev-util/cmake-2.4
	!app-cdr/cdrtools
	sys-libs/libcap"

PROVIDE="virtual/cdrtools"

S="${WORKDIR}/${MY_P}"

src_compile() {
	cmake \
		-DCMAKE_INSTALL_PREFIX=/usr \
		-DCMAKE_C_COMPILER=$(which $(tc-getCC))

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	dosym /usr/bin/wodim /usr/bin/cdrecord

	cd ${S}
	dodoc ABOUT Changelog FAQ FORK START TODO VERSION

	cd ${S}/doc/READMEs
	dodoc README*

	cd ${S}/doc/wodim
	dodoc README*

	cd ${S}/doc/cdda2wav
	docinto cdda2wav
	dodoc FAQ Frontends HOWTOUSE README TODO

	cd ${S}/doc/mkisofs
	docinto mkisofs
	dodoc *

	cd ${S}/doc/plattforms/
	docinto platforms
	dodoc README.{linux,parallel}

	cd ${S}
	insinto /etc
	newins cdrecord/wodim.dfl wodim.conf

	cd ${S}
	insinto /usr/include/scsilib
	doins include/*.h
	insinto /usr/include/scsilib/scg
	doins include/scg/*.h
}
