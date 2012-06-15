# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/cdsclient/cdsclient-3.7.1.ebuild,v 1.1 2012/06/15 17:02:57 bicatali Exp $

EAPI=4

inherit eutils versionator

# upstream versioning wrong: 3.71 is really 3.7.1
MYP="${PN}-$(delete_version_separator 2)"

DESCRIPTION="Collection of scripts to access the CDS databases"
HOMEPAGE="http://cdsweb.u-strasbg.fr/doc/cdsclient.html"
SRC_URI="ftp://cdsarc.u-strasbg.fr/pub/sw/${MYP}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="app-shells/tcsh"

S="${WORKDIR}/${MYP}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-gentoo.diff
	# remove non standard "mantex" page
	sed -i -e 's/aclient.tex//'	"${S}"/configure || die
}

src_install() {
	local bindir=/usr/bin/${PN}
	emake DESTDIR="${D}" SHSDIR=${bindir} install
	cat <<-EOF > 99${PN}
		PATH=${EPREFIX}${bindir}
		ROOTPATH=${EPREFIX}${bindir}
	EOF
	doenvd 99${PN}
}
