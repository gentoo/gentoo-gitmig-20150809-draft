# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/blender/blender-2.26.ebuild,v 1.2 2003/02/13 12:31:05 vapier Exp $

DESCRIPTION="3D Creation/Animation/Publishing System"

HOMEPAGE="http://www.blender.org/"
SRC_URI="http://download.blender.org/source/${P}.tar.bz2"
LICENSE="GPL-2 BL"
SLOT="0"
KEYWORDS="~x86 ~ppc"
S="${WORKDIR}/${P}"
IUSE=""

DEPEND="
	virtual/x11
	>=openal-20020127
	>=libsdl-1.2
	>=libvorbis-1.0
	>=openssl-0.9.6
"

src_compile() {
	econf --enable-openal || die
	emake || die
}

src_install() {
	einstall
}
