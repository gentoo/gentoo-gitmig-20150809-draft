# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/grc/grc-1.0.6.ebuild,v 1.8 2004/10/05 13:34:51 pvdabeel Exp $

inherit eutils

DESCRIPTION="Generic Colouriser is yet another colouriser for beautifying your logfiles or output of commands"
HOMEPAGE="http://melkor.dnp.fmph.uniba.sk/~garabik/grc.html"
SRC_URI="http://melkor.dnp.fmph.uniba.sk/~garabik/grc/grc_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

RDEPEND="dev-lang/python"

src_unpack() {
	unpack ${A}
	cp -rf ${S}{,.orig}
	cd ${S}
	epatch ${FILESDIR}/${PV}-support-more-files.patch
}

src_install() {
	insinto /usr/share/grc
	doins conf.* ${FILESDIR}/conf.* || die "share files"
	insinto /etc
	doins grc.conf || die "conf"
	dobin grc grcat || die "dobin"
	dodoc README INSTALL TODO CHANGES CREDITS
	doman grc.1 grcat.1
}
