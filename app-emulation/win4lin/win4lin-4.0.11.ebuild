# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/win4lin/win4lin-4.0.11.ebuild,v 1.1 2002/12/13 00:40:08 seemant Exp $

IUSE="X gnome"

MY_P=Win4Lin-5.3.11a-d.i386
S=${WORKDIR}
DESCRIPTION="Win4Lin allows you run Windows applications somewhat natively
under linux."
HOMEPAGE="http://www.netraverse.com/"
SRC_URI="Win4Lin-5.3.11a-d.i386.rpm"

SLOT="0"
LICENSE="NeTraverse"
KEYWORDS=""

DEPEND="app-arch/rpm2targz"

RESTRICT="nofetch"


# The rpm for this can be downloaded from www.netraverse.com after you
# register there.  Please place Win4Lin-5.3.11a-d.i386.rpm into
# /usr/portage/distfiles after downloading, then emerge win4lin again

src_unpack() {
	rpm2targz ${DISTDIR}/${MY_P}.rpm
	tar zxf ${WORKDIR}/${MY_P}.tar.gz
}

src_compile() {
	echo "nothing to compile; binary package."
}

src_install() {
	mv ${S}/opt ${D}
}
