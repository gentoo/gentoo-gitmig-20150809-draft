# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cdtool/cdtool-2.1.5-r1.ebuild,v 1.5 2007/02/03 23:23:33 beandog Exp $

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="A package of command-line utilities to play and catalog cdroms."
HOMEPAGE="http://hinterhof.net/cdtool/"
SRC_URI="http://hinterhof.net/cdtool/dist/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc amd64 ppc"
IUSE="debug"
DEPEND="!media-sound/cdplay"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch "${FILESDIR}/${P}-ldflags.patch"
}

src_compile() {
	use debug && append-flags -DDEBUG
	emake CC="$(tc-getCC)" LDFLAGS="${LDFLAGS}" || die "make failed"
}

src_install() {
	dobin cdadd
	dobin cdctrl
	dobin cdown
	dobin cdloop
	dobin cdtool

	dosym cdtool /usr/bin/cdpause
	dosym cdtool /usr/bin/cdeject
	dosym cdtool /usr/bin/cdinfo
	dosym cdtool /usr/bin/cdir
	dosym cdtool /usr/bin/cdreset
	dosym cdtool /usr/bin/cdshuffle
	dosym cdtool /usr/bin/cdstart
	dosym cdtool /usr/bin/cdstop
	dosym cdtool /usr/bin/cdplay

	doman cdctrl.1 cdown.1 cdtool.1

	dodoc README
}
