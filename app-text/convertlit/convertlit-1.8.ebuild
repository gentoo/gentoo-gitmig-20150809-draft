# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/convertlit/convertlit-1.8.ebuild,v 1.8 2005/10/27 00:32:24 vapier Exp $

MY_P="clit${PV//./}"

DESCRIPTION="CLit converts MS ebook .lit files to .opf (xml+html+png+jpg)"
HOMEPAGE="http://www.convertlit.com/"
SRC_URI="http://www.convertlit.com/${MY_P}src.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc-macos x86"
IUSE=""

DEPEND="dev-libs/libtommath
	>=sys-apps/sed-4
	app-arch/unzip"
RDEPEND="!app-text/open_c-lit"	# link libtommath statically

S=${WORKDIR}

src_compile() {
	cd "${S}"/lib
	sed -i -e "/^CFLAGS/s/-O3 -Wall/${CFLAGS}/" Makefile \
		|| die "sed lib/Makefile failed."
	emake || die "make lib failed"
	cd "${S}"/${MY_P}
	sed -i -e "/^CFLAGS/s:-Wall -O2:${CFLAGS}:" \
		-e "s:../libtommath-0.30:/usr/lib:g" Makefile \
		|| die "sed ${MY_P}/Makefile failed."
	emake || die "make ${MY_P} failed"
}

src_install() {
	dobin ${MY_P}/clit || die
	dodoc README
}
