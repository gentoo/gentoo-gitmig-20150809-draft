# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/lineak-kdeplugins/lineak-kdeplugins-0.8.3.ebuild,v 1.7 2005/11/24 20:07:39 blubb Exp $

inherit kde multilib

MY_PV=${PV/_/}
MY_P=${PN/-/_}-${MY_PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="KDE plugins for LINEAK"
HOMEPAGE="http://lineak.sourceforge.net/"
SRC_URI="mirror://sourceforge/lineak/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="virtual/x11
	x11-misc/lineakd"

need-kde 3.2

src_install() {
	make DESTDIR=${D} PLUGINDIR=${D}/usr/$(get_libdir)/lineakd/plugins lineakddocdir=/usr/share/doc/${P} install || die
	dodoc AUTHORS README TODO
}
