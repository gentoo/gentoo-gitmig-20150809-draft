# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-misc/fspanel/fspanel-0.8_beta1.ebuild,v 1.1 2002/07/29 19:17:21 stroke Exp $

S=${WORKDIR}/fspanel-0.8beta1
DESCRIPTION="F***ing Small Panel. Good (and small) replacement for gnome-panel"
SRC_URI="http://www.chatjunkies.org/fspanel/fspanel-0.8beta1.tar.gz"
HOMEPAGE="http://www.chatjunkies.org/fspanel"

SLOT="0"
KEYWORDS="x86"
LICENSE="GPL-2"

DEPEND="virtual/x11"
RDEPEND="${DEPEND}"

src_compile() {

	./configure
	emake || die
}

src_install () {
	exeinto /usr/bin
	doexe ${S}/fspanel

	dodoc README
}
