# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/lineak-defaultplugin/lineak-defaultplugin-0.8.4.ebuild,v 1.2 2006/09/03 20:22:07 nelchael Exp $

inherit multilib

MY_P=${PN/-/_}-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Mute/unmute and other macros for LINEAK"
HOMEPAGE="http://lineak.sourceforge.net/"
SRC_URI="mirror://sourceforge/lineak/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~ppc x86"

RDEPEND="=x11-misc/lineakd-${PV}*"
DEPEND="${RDEPEND}"

src_install() {
	make DESTDIR=${D} \
		PLUGINDIR=/usr/$(get_libdir)/lineakd/plugins \
		lineakddocdir=/usr/share/doc/${P} \
		install || die "make install failed"
	dodoc AUTHORS README
}
