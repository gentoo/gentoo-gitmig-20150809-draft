# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Seemant Kulleen <seemant@rocketmail.com>
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gkrellmoon/gkrellmoon-0.3.ebuild,v 1.1 2002/02/20 02:31:28 agriffis Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A Gkrellm plugin of the famous wmMoonClock dockapp"
SRC_URI="http://prdownloads.sourceforge.net/gkrellmoon/${P}.tar.gz"
HOMEPAGE="http://gkrellmoon.sourceforge.net/"

DEPEND=">=app-admin/gkrellm-1.0.6
		>=x11-libs/gtk+-1.2.10-r4
		>=media-libs/imlib-1.9.10-r1"

src_compile() {
    emake || die
}

src_install () {
    exeinto /usr/lib/gkrellm/plugins
    doexe gkrellmoon.so
    dodoc README AUTHORS COPYING
}
