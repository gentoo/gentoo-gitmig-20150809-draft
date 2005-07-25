# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/pd-cyclone/pd-cyclone-0.1_alpha54.ebuild,v 1.2 2005/07/25 19:05:38 dholm Exp $

inherit eutils versionator

MY_PV=$(replace_version_separator 2 '-')
DESCRIPTION="cyclone external for pure data"
HOMEPAGE="http://suita.chopin.edu.pl/~czaja/miXed/externs/cyclone.html"
SRC_URI="http://suita.chopin.edu.pl/~czaja/miXed/externs/cyclone-${MY_PV}-src.tar.gz"

LICENSE="|| ( BSD as-is )"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

S=${WORKDIR}/cyclone

RDEPEND="media-sound/pd"

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}

	# build system not fine grained enough to only compile
	# the shared object with fPIC
	epatch ${FILESDIR}/${P}-fPIC.patch
}

src_compile() {
	emake OUR_CFLAGS="${CFLAGS}" || die "make failed"
}

src_install() {
	install -d ${WORKDIR}/bin/  ${D}/usr/lib/pd/extra/
	install ${WORKDIR}/bin/*.pd_linux  ${D}/usr/lib/pd/extra/
}
