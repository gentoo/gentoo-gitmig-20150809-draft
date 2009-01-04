# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/glimmer/glimmer-3.02-r1.ebuild,v 1.1 2009/01/04 01:24:22 weaver Exp $

inherit versionator

MY_PV=$(delete_all_version_separators)

DESCRIPTION="An HMM-based microbial gene finding system from TIGR"
HOMEPAGE="http://www.cbcb.umd.edu/software/glimmer/"
SRC_URI="http://www.cbcb.umd.edu/software/${PN}/${PN}${MY_PV}.tar.gz"

LICENSE="Artistic"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="!app-crypt/pkcrack
	!media-libs/libextractor"

S="${WORKDIR}/${PN}${PV}"

src_compile() {
	sed -i -e 's|\(set awkpath =\).*|\1 /usr/share/'${PN}'/scripts|' \
		-e 's|\(set glimmerpath =\).*|\1 /usr/bin|' scripts/* || die "failed to rewrite paths"
	sed -i 's/include  <string>/include  <string.h>/' src/Common/delcher.hh
	cd src
	emake || die "emake failed"
}

src_install() {
	rm bin/test
	dobin bin/*

	dodir /usr/share/${PN}/scripts
	insinto /usr/share/${PN}/scripts
	doins scripts/*

	dodoc glim302notes.pdf
}
