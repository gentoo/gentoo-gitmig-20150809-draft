# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellmoon/gkrellmoon-0.3.ebuild,v 1.5 2002/12/09 04:41:57 manson Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A GKrellM plugin of the famous wmMoonClock dockapp"
SRC_URI="mirror://sourceforge/gkrellmoon/${P}.tar.gz"
HOMEPAGE="http://gkrellmoon.sourceforge.net/"

DEPEND="=app-admin/gkrellm-1.2*
	>=media-libs/imlib-1.9.10-r1"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc "

src_compile() {
	emake || die
}

src_install () {
	insinto /usr/lib/gkrellm/plugins
	doins gkrellmoon.so
	dodoc README AUTHORS COPYING
}
