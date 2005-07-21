# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/mtoolsfm/mtoolsfm-1.9.3.ebuild,v 1.13 2005/07/21 17:24:22 dholm Exp $

inherit eutils

MY_P="MToolsFM-1.9-3"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="easy floppy-access under linux / UNIX"
HOMEPAGE="http://www.core-coutainville.org/MToolsFM/"
SRC_URI="http://www.core-coutainville.org/MToolsFM/archive/SOURCES/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""

DEPEND="=x11-libs/gtk+-1.2*
	sys-fs/mtools"

src_unpack() {
	unpack ${A} || die
	cd ${S} || die
	epatch ${FILESDIR}/mtoolsfm.c.diff
	epatch ${FILESDIR}/ascii.patch
}

src_install() {
	einstall install_prefix=${D}
	dodoc AUTHORS ChangeLog NEWS README THANKS
}
