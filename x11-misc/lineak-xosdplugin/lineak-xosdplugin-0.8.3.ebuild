# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/lineak-xosdplugin/lineak-xosdplugin-0.8.3.ebuild,v 1.11 2006/09/09 00:57:49 tcort Exp $

inherit multilib

IUSE=""
MY_PV=${PV/_/}
MY_P=${PN/-/_}-${MY_PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Xosd plugin for LINEAK"
HOMEPAGE="http://lineak.sourceforge.net/"
SRC_URI="mirror://sourceforge/lineak/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"

RDEPEND="=x11-misc/lineakd-${PV}*
		x11-libs/xosd"
DEPEND="${RDEPEND}"

src_compile() {
	econf --with-x || die "econf failed"
	emake || die "emake failed"
}

src_install () {
	make DESTDIR=${D} PLUGINDIR=/usr/$(get_libdir)/lineakd/plugins lineakddocdir=/usr/share/doc/${P} install || die
	dodoc AUTHORS README TODO
}
