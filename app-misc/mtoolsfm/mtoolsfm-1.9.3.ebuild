# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/mtoolsfm/mtoolsfm-1.9.3.ebuild,v 1.1 2003/07/15 14:45:24 lanius Exp $

DESCRIPTION="MToolsFM - easy floppy-access under linux / UNIX "
HOMEPAGE="http://www.core-coutainville.org/MToolsFM/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
MY_P="MToolsFM-1.9-3"
SRC_URI="http://www.core-coutainville.org/MToolsFM/archive/SOURCES/${MY_P}.tar.gz"
IUSE=""

S="${WORKDIR}/${MY_P}"

DEPEND="=gtk+-1.2*
	mtools"

src_unpack() {
	unpack ${A} || die
	cd ${S} || die
	epatch ${FILESDIR}/mtoolsfm.c.diff
}

src_install() {
	einstall install_prefix=${D}
	dodoc AUTHORS COPYING ChangeLog NEWS README THANKS
}
