# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/pep/pep-2.8.ebuild,v 1.15 2012/12/16 17:49:20 armin76 Exp $

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="General purpose filter and file cleaning program"
HOMEPAGE="http://folk.uio.no/gisle/enjoy/pep.html"
SRC_URI="http://folk.uio.no/gisle/enjoy/${PN}${PV//./}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~mips ppc x86 ~x86-linux ~ppc-macos"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=""

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	# pep does not come with autconf so here's a patch to configure
	# Makefile with the correct path
	epatch "${FILESDIR}"/${P}-gentoo.patch
	# Darwin lacks stricmp
	[[ ${CHOST} == *-darwin* ]] && \
		sed -i -e '/^OBJS/s/^\(.*\)$/\1 bdmg.o/' Makefile
}

src_compile() {
	[[ ${CHOST} == *-darwin* ]] && \
		append-flags "-DDIRCHAR=\\'/\\'" -DSTRICMP
	# make man page too
	make Doc/pep.1 || die "make man page failed"
	emake CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	dobin pep || die "dobin failed"
	doman Doc/pep.1 || die "doman failed"

	insinto /usr/share/pep
	doins Filters/* || die "doins failed"

	dodoc aareadme.txt file_id.diz
}
