# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-misc/alltraxclock/alltraxclock-0.2.ebuild,v 1.7 2002/08/14 23:44:14 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A Gkrellm plugin that displays an analog clock"
SRC_URI="http://perso.wanadoo.fr/alltrax/${P}.tar.gz"
HOMEPAGE="http://perso.wanadoo.fr/alltrax/alltraxclock.html"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc sparc64"

DEPEND=">=app-admin/gkrellm-1.0.6
		=x11-libs/gtk+-1.2*
		>=media-libs/imlib-1.9.10-r1"

src_compile() {
	emake || die
}

src_install () {
	exeinto /usr/lib/gkrellm/plugins
	doexe alltraxclock.so
}
