# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/mtoolsfm/mtoolsfm-1.9.3.ebuild,v 1.15 2011/03/28 16:28:20 angelos Exp $

EAPI=3
inherit eutils

MY_P=MToolsFM-1.9-3

DESCRIPTION="easy floppy-access under linux / UNIX"
HOMEPAGE="http://www.core-coutainville.org/MToolsFM/"
SRC_URI="http://www.core-coutainville.org/MToolsFM/archive/SOURCES/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""

DEPEND="x11-libs/gtk+:1
	sys-fs/mtools"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}"/mtoolsfm.c.diff \
		"${FILESDIR}"/ascii.patch
}

src_install() {
	einstall install_prefix="${ED}"
	dodoc AUTHORS ChangeLog NEWS README THANKS
}
