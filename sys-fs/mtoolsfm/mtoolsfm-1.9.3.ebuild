# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/mtoolsfm/mtoolsfm-1.9.3.ebuild,v 1.1 2003/09/17 03:54:28 seemant Exp $

inherit eutils

S=${WORKDIR}/MToolsFM-${PV}
DESCRIPTION="easy floppy-access under linux / UNIX"
HOMEPAGE="http://www.core-coutainville.org/MToolsFM/"
SRC_URI="http://www.core-coutainville.org/MToolsFM/archive/SOURCES/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="=x11-libs/gtk+-1.2*
	sys-fs/mtools"

src_unpack() {
	unpack ${A} || die
	cd ${S} || die
	epatch ${FILESDIR}/mtoolsfm.c.diff
}

src_install() {
	einstall install_prefix=${D}
	dodoc AUTHORS COPYING ChangeLog NEWS README THANKS
}
