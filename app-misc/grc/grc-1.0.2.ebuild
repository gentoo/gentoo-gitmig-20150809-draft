# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/grc/grc-1.0.2.ebuild,v 1.8 2004/03/14 10:50:54 mr_bones_ Exp $

DESCRIPTION="Generic Colouriser is yet another colouriser for beautifying your logfiles or output of commands"
SRC_URI="http://melkor.dnp.fmph.uniba.sk/~garabik/grc/grc_1.0.2.tar.gz"
HOMEPAGE="http://melkor.dnp.fmph.uniba.sk/~garabik/grc.html"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="dev-lang/python"

src_install()  {
	insinto /usr/share/grc
	doins conf.*
	insinto /etc
	doins grc.conf
	dobin grc grcat
	dodoc README INSTALL TODO CHANGES CREDITS
	doman grc.1 grcat.1
}
