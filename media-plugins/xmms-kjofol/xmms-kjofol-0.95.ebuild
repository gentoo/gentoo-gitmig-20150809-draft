# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-kjofol/xmms-kjofol-0.95.ebuild,v 1.6 2004/03/29 23:13:49 dholm Exp $

DESCRIPTION="A xmms remote that allows users to use K-Jofol skins"
HOMEPAGE="http://www.csse.monash.edu.au/~timf/xmms.html"
SRC_URI="http://www.dgs.monash.edu.au/~timf/kint_xmms-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"

DEPEND="media-sound/xmms"

S=${WORKDIR}/${PN/ofol}

src_compile() {
	emake || die
}

src_install() {
	dobin kj
	dodir /usr/share/xmms/kjofol
	cp *.zip ${D}usr/share/xmms/kjofol
	dodoc readme.txt COPYING
}

pkg_postinst() {
	einfo "This plugin works as a remote for XMMS. Start XMMS before"
	einfo "using this plugin with kj"
	einfo "Place K-Jofol skins in ~/.xmms/kjofol/"
}
