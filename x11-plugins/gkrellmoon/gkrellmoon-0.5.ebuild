# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellmoon/gkrellmoon-0.5.ebuild,v 1.1 2002/11/11 07:16:12 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A GKrellM2 plugin of the famous wmMoonClock dockapp"
SRC_URI="mirror://sourceforge/gkrellmoon/${P}.tar.gz"
HOMEPAGE="http://gkrellmoon.sourceforge.net/"

DEPEND="=app-admin/gkrellm-2*
	>=media-libs/imlib-1.9.10-r1"

SLOT="2"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64"

src_compile() {
	emake || die
}

src_install () {

	insinto /usr/lib/gkrellm2/plugins
	doins gkrellmoon.so
	dodoc README AUTHORS COPYING
}
