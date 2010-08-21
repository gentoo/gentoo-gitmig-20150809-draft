# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/msms/msms-2.6.1.ebuild,v 1.1 2010/08/21 22:58:28 alexxy Exp $

EAPI=3

DESCRIPTION="MSMS allows to compute very efficiently triangulations of Solvent Excluded Surfaces"
HOMEPAGE="http://mgl.scripps.edu/people/sanner/html/msms_home.html"
SRC_URI="
			amd64? ( msms_i86_64Linux2_2.6.1.tar.gz )
			x86? ( msms_i86Linux2_2.6.1.tar.gz )
"

LICENSE="MSMS"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

RESTRICT="fetch binchecks"

S="${WORKDIR}"

pkg_nofetch() {
	einfo
	einfo "Please download ${SRC_URI} and place it to ${DISTDIR}"
	einfo
}

src_install() {
	doman msms.1
	dodoc README msms.html ReleaseNotes
	if use amd64; then
		newbin ${PN}.x86_64Linux2.${PV} msms
	elif use x86; then
		newbin ${PN}.i86Linux2.${PV} msms
	fi
}
