# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cdtool/cdtool-2.1.5.ebuild,v 1.1 2003/04/22 20:51:40 coredumb Exp $

IUSE=""
DESCRIPTION="A package of command-line utilities to play and catalog cdroms."
HOMEPAGE=""
SRC_URI="http://www.ibiblio.org/pub/linux/apps/sound/cdrom/cli/cdtool-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
DEPEND=""
S=${WORKDIR}/${P}

src_compile() {
	cd ${S}
	emake || die
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
	
	doman cdctrl.1 cdown.1 cdtool.1

	dodoc COPYING INSTALL README

}
