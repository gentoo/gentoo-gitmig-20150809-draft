# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/shelx/shelx-20060317.ebuild,v 1.7 2008/11/07 01:01:03 dberkholz Exp $

inherit autotools eutils fortran

MY_P="unix"
MY_SRC_URI="${MY_P}.tgz"

DESCRIPTION="Programs for crystal structure determination from single-crystal diffraction data"
HOMEPAGE="http://shelx.uni-ac.gwdg.de/SHELX/"
SRC_URI="${P}.tgz"
RESTRICT="fetch"
LICENSE="free-noncomm"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE="dosformat"
RDEPEND=""
DEPEND="${RDEPEND}"
S="${WORKDIR}/${MY_P}"

FORTRAN="ifc gfortran"

pkg_nofetch() {
	einfo "Go to ${HOMEPAGE}"
	einfo "Fill out the application form, and send it in."
	einfo "Download ${MY_SRC_URI}, rename it to ${SRC_URI},"
	einfo "and place it in ${DISTDIR}."
}

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${PV}-autotool.patch
	epatch "${FILESDIR}"/${PV}-gfortran.patch

	sed -i \
		-e "s:CIFDIR='/usr/local/bin/':CIFDIR='/usr/share/${PN}/':g" \
		"${S}"/ciftab.f

	if use dosformat; then
		sed -i \
			-e "s/KD=CHAR(32)/KD=CHAR(13)/g" \
			"${S}"/*f
	fi

	cd "${S}"
	eautoreconf
}

src_compile() {
	econf \
		FC="${FORTRANC}" \
		|| die "configure failed"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
}
