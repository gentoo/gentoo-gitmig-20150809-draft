# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/psmix/psmix-2.ebuild,v 1.2 2002/07/11 06:30:41 drobbins Exp $

A="psmix2.tgz"
S="${WORKDIR}/psmix2"

DESCRIPTION="A GTK audio mixer that can save state and window position."
SRC_URI="http://www.geocities.com/pssoft7/${A}"
HOMEPAGE="http://www.geocities.com/pssoft7/"

DEPEND="x11-libs/gtk+
	sys-libs/gdbm"

src_compile() {
	make clean
	emake || die
}

src_install () {
	dobin psmix2
}
