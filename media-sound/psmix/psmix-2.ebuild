# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/psmix/psmix-2.ebuild,v 1.7 2004/04/20 17:31:24 eradicator Exp $

IUSE=""

MY_P=${P/-/}
S=${WORKDIR}/${MY_P}

DESCRIPTION="A GTK audio mixer that can save state and window position."
SRC_URI="http://www.geocities.com/pssoft7/${MY_P}.tgz"
HOMEPAGE="http://www.geocities.com/pssoft7/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="x11-libs/gtk+
	sys-libs/gdbm"

src_compile() {
	make clean
	emake || die
}

src_install () {
	dobin psmix2
}
