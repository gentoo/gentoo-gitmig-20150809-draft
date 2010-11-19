# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/htmlrecode/htmlrecode-1.3.0-r1.ebuild,v 1.1 2010/11/19 02:09:40 sping Exp $

inherit eutils

DESCRIPTION="Recodes HTML file using a new character set"
HOMEPAGE="http://bisqwit.iki.fi/source/htmlrecode.html"
SRC_URI="http://bisqwit.iki.fi/src/arch/${P}.tar.bz2"

KEYWORDS="~amd64 ~ppc ~x86"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND=">=sys-apps/sed-4"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-misc-fixes.patch

	sed -i \
		-e "s:^\\(ARGHLINK.*-L.*\\):#\\1:" \
		-e "s:^#\\(ARGHLINK=.*a\\)$:\\1:" \
		Makefile

	touch .depend argh/.depend

	for i in {,argh/}Makefile.sets ; do
		einfo "Patching compile flags in \${S}/$i ..."
		echo "CXXFLAGS=${CXXFLAGS}" >> "${i}"
		echo "LDFLAGS=${LDFLAGS}" >> "${i}"
	done
}

src_compile() {
	emake -C argh libargh.a || die
	emake htmlrecode || die
}

src_install() {
	dobin htmlrecode || die
	dodoc README.html
}
