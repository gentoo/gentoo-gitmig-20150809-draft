# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cdtool/cdtool-2.1.5-r1.ebuild,v 1.1 2005/04/20 19:01:26 luckyduck Exp $

DESCRIPTION="A package of command-line utilities to play and catalog cdroms."
HOMEPAGE=""
SRC_URI="http://www.ibiblio.org/pub/linux/apps/sound/cdrom/cli/cdtool-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc amd64 ppc"
IUSE=""
DEPEND="!media-sound/cdplay"

src_compile() {
	emake || die "make failed"
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

	dodoc INSTALL README
}
