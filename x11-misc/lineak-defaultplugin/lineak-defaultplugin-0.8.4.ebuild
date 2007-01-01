# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/lineak-defaultplugin/lineak-defaultplugin-0.8.4.ebuild,v 1.4 2007/01/01 21:43:38 mabi Exp $

inherit multilib

MY_P=${PN/-/_}-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Mute/unmute and other macros for LINEAK"
HOMEPAGE="http://lineak.sourceforge.net/"
SRC_URI="mirror://sourceforge/lineak/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="amd64 ppc x86"

RDEPEND="=x11-misc/lineakd-${PV}*"
DEPEND="${RDEPEND}"

src_install() {
	make DESTDIR=${D} \
		PLUGINDIR=/usr/$(get_libdir)/lineakd/plugins \
		lineakddocdir=/usr/share/doc/${P} \
		install || die "make install failed"
	dodoc AUTHORS README
}
