# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/flasm/flasm-1.62.ebuild,v 1.3 2011/08/11 02:28:20 vapier Exp $

inherit eutils versionator toolchain-funcs

MY_PV=$(delete_all_version_separators $(get_version_component_range 1-2))
DESCRIPTION="Command line assembler/disassembler of Flash ActionScript bytecode"
HOMEPAGE="http://www.nowrap.de/flasm.html"
SRC_URI="http://www.nowrap.de/download/flasm${MY_PV}src.zip"
RESTRICT="mirror"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="sys-libs/zlib"
DEPEND="${RDEPEND}
	app-arch/unzip
	sys-devel/flex
	virtual/yacc
	dev-util/gperf"

S="${WORKDIR}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-makefile.patch
	epatch "${FILESDIR}"/${P}-bison-2.patch
}

src_compile() {
	tc-export CC
	emake || die "emake failed"
}

src_install() {
	dobin flasm
	dodoc CHANGES.TXT
	dohtml flasm.html classic.css
}

pkg_postinst() {
	elog
	elog "This is a version bump to fix the version number"
	elog "of flasm and offers no changes from the previous 1.6.2."
	elog "For more details check bug 276451"
	elog
}
