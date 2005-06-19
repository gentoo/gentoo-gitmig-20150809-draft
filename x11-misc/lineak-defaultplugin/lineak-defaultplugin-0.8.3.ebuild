# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/lineak-defaultplugin/lineak-defaultplugin-0.8.3.ebuild,v 1.3 2005/06/19 20:32:32 smithj Exp $

MY_PV=${PV/_/}
MY_P=${PN/-/_}-${MY_PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Mute/unmute and other macros for LINEAK"
HOMEPAGE="http://lineak.sourceforge.net/"
SRC_URI="mirror://sourceforge/lineak/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"
IUSE=""

RDEPEND="virtual/x11
		x11-misc/lineakd"

src_install () {
	make DESTDIR=${D} lineakddocdir=/usr/share/doc/${MY_P} install || die
	dodoc AUTHORS README
}
