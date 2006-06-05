# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/shelx/shelx-20060317.ebuild,v 1.1 2006/06/05 09:01:43 spyderous Exp $

inherit autotools eutils fortran

MY_P="unix"
MY_SRC_URI="${MY_P}.tgz"

DESCRIPTION="Programs for crystal structure determination from single-crystal diffraction data"
HOMEPAGE="http://shelx.uni-ac.gwdg.de/SHELX/"
SRC_URI="${P}.tgz"
RESTRICT="fetch"
LICENSE="free-noncomm"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RDEPEND=""
DEPEND="${RDEPEND}"
S="${WORKDIR}/${MY_P}"

FORTRAN="ifc"

pkg_nofetch() {
	einfo "Go to ${HOMEPAGE}"
	einfo "Fill out the application form, and send it in."
	einfo "Download ${MY_SRC_URI}, rename it to ${SRC_URI},"
	einfo "and place it in ${DISTDIR}."
}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-autotool.patch

	sed -i \
		-e "s:CIFDIR='/usr/local/bin/':CIFDIR='${ROOT}usr/share/${PN}/':g" \
		"${S}"/ciftab.f

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
