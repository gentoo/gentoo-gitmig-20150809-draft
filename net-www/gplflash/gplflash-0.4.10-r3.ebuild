# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/gplflash/gplflash-0.4.10-r3.ebuild,v 1.2 2003/10/04 01:11:15 hillster Exp $

inherit nsplugins

S=${WORKDIR}/flash-0.4.10
DESCRIPTION="GPL Shockwave Flash Player/Plugin, Supports Older Ver <=4 Only"
SRC_URI="http://www.swift-tools.net/Flash/flash-0.4.10.tgz"
HOMEPAGE="http://www.swift-tools.net/Flash"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc"

DEPEND="media-libs/libflash"
RDEPEND="!net-www/netscape-flash"

src_unpack() {
	cd ${WORKDIR}
	unpack flash-0.4.10.tgz
	cd ${S}
	epatch ${FILESDIR}/${P}-gcc3-gentoo.diff || die

	if [ "${ARCH}" = "ppc" ]; then
		epatch ${FILESDIR}/${P}-ppc.diff || die
	fi
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
