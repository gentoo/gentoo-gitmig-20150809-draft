# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/blender/blender-2.26_pre20030109.ebuild,v 1.2 2003/01/12 13:05:10 mholzer Exp $

DESCRIPTION="3D Creation/Animation/Publishing System"

HOMEPAGE="http://www.blender.org/"
SRC_URI="mirror://gentoo/blender-2.26-pre20030109.tar.bz2"
LICENSE="GPL-2 BL"
SLOT="0"
KEYWORDS="~x86 ~ppc"

S="${WORKDIR}/blender-20030109"

IUSE="oggvorbis ssl"

# Build-time dependencies, such as
#    ssl? ( >=openssl-0.9.6b )
#    >=perl-5.6.1-r1
# It is advisable to use the >= syntax show above, to reflect what you
# had installed on your system when you tested the package.  Then
# other users hopefully won't be caught without the right version of
# a dependency.
DEPEND="
	virtual/x11
	>=openal-20020127
	>=libsdl-1.2
	oggvorbis? ( >=libvorbis-1.0 )
	ssl? ( >=openssl-0.9.6 )
"

src_compile() {
	local myconf

	econf ${myconf} --enable-openal || die "./configure failed"
	emake || die
}

src_install() {
	einstall
}
