# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/ortep3/ortep3-1.0.3-r1.ebuild,v 1.2 2010/12/16 15:20:57 jlec Exp $

inherit toolchain-funcs

DESCRIPTION="Thermal ellipsoid plot program for crystal structure illustrations"
HOMEPAGE="http://www.ornl.gov/sci/ortep/"
SRC_URI="ftp://ftp.ornl.gov/pub/ortep/src/ortep.f"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="
	sci-libs/pgplot
	x11-libs/libX11"
DEPEND="${RDEPEND}"

S="${WORKDIR}"

src_unpack() {
	cp "${DISTDIR}"/${A} "${S}" || die
}

src_compile() {
	COMMAND="$(tc-getFC) ${FFLAGS:- -O2} ${LDFLAGS} -o ${PN} ortep.f -lpgplot -lX11"
	echo ${COMMAND}
	${COMMAND} || die "Compilation failed"
}

src_install() {
	dobin ${PN} || die
}
