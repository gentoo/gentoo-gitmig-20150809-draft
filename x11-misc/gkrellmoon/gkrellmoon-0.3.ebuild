# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gkrellmoon/gkrellmoon-0.3.ebuild,v 1.8 2002/08/02 17:57:38 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A GKrellM plugin of the famous wmMoonClock dockapp"
SRC_URI="mirror://sourceforge/gkrellmoon/${P}.tar.gz"
HOMEPAGE="http://gkrellmoon.sourceforge.net/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=app-admin/gkrellm-1.0.6
		=x11-libs/gtk+-1.2*
		>=media-libs/imlib-1.9.10-r1"

src_compile() {
	emake || die
}

src_install () {
	insinto /usr/lib/gkrellm/plugins
	doins gkrellmoon.so
	dodoc README AUTHORS COPYING
}
