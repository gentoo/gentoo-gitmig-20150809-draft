# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/xchat-xsys/xchat-xsys-1.9.3-r1.ebuild,v 1.1 2005/05/14 13:13:09 chainsaw Exp $

inherit eutils

MY_P="${P/xchat-/}"
DESCRIPTION="Sysinfo plugin for X-Chat."
SRC_URI="http://mshoup.us/downloads/xsys/${MY_P}.tar.bz2"
HOMEPAGE="http://mshoup.us/downloads/xsys/README-${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64 ~ppc"
IUSE="bmp xmms"
S=${WORKDIR}/xsys2

DEPEND=">=net-irc/xchat-2.4.0
	bmp? (media-plugins/bmp-infopipe)
	xmms? (media-plugins/xmms-infopipe)"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-sysfs-instead-of-lspci-2.patch
	epatch ${FILESDIR}/${PV}-ppc-support.patch
}

src_compile() {
	emake -j1 || die "Compile failed"
}

src_install() {
	exeinto /usr/$(get_libdir)/xchat/plugins
	doexe xsys-${PV}.so

	dodoc ChangeLog README
}
