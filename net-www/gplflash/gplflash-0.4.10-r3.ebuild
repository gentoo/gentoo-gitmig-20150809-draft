# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/gplflash/gplflash-0.4.10-r3.ebuild,v 1.3 2004/02/07 20:25:44 vapier Exp $

inherit nsplugins eutils

DESCRIPTION="GPL Shockwave Flash Player/Plugin, Supports Older Ver <=4 Only"
HOMEPAGE="http://www.swift-tools.net/Flash/"
SRC_URI="http://www.swift-tools.net/Flash/flash-0.4.10.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64"

DEPEND="media-libs/libflash"
RDEPEND="!net-www/netscape-flash"

S=${WORKDIR}/flash-${PV}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gcc3-gentoo.diff
	use amd64 && epatch ${FILESDIR}/${P}-fPIC.patch
	use ppc && epatch ${FILESDIR}/${P}-ppc.diff
}

src_compile() {
	emake || die
}

src_install() {
	cd ${S}/Plugin
	insinto /opt/netscape/plugins
	doins npflash.so
	inst_plugin /opt/netscape/plugins/npflash.so
	cd ${S}
	dodoc README COPYING
}

pkg_postinst() {
	einfo
	einfo "Only Supports older version 4 and below flash"
	einfo "animations on version 5 and above (most websites)"
	einfo "you will experiance freezes. if in doubt unmerge"
	einfo "net-www/gplflash and merge net-www/netscape-flash"
	einfo "for version 5 and above"
	einfo
}
