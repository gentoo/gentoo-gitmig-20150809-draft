# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/uade/uade-0.73.ebuild,v 1.3 2004/01/06 03:40:24 mr_bones_ Exp $

DESCRIPTION='Unix Amiga Delitracker Emulator - plays old Amiga tunes through UAE emulation and cloned m68k-assembler Eagleplayer API'
HOMEPAGE='http://ee.tut.fi/~heikki/uade.html'
SRC_URI="http://ee.tut.fi/~heikki/uade/${P}.tar.bz2"

LICENSE='GPL-2'
KEYWORDS='x86'
SLOT='0'

IUSE='xmms sdl'
RDEPEND="dev-lang/perl
	xmms? ( >=media-sound/xmms-1.2.2 x11-libs/gtk+ )
	sdl? ( media-libs/libsdl )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i \
		-e 's:\$prefix/doc:/usr/share/doc:' configure || \
			die 'sed configure failed'
}

src_compile() {
	local myconf="--package-prefix=${D}"
	use sdl	&& myconf="$myconf --with-sdl"
	use xmms || myconf="$myconf --no-plugin"

	econf ${myconf} || die
	# warning...broken Makefiles ahead.
	emake -j1 || die 'emake failed'
}

src_install() {
	make DESTDIR=${D} install || die 'make install failed'
	dodoc BUGS ChangeLog.txt FIXED
	rm -f ${D}/usr/share/doc/${P}/COPYING
	find ${D}/usr/share/doc/${P}/ \
		\( -name '*.readme'	-o \
		-name '*.txt'		-o \
		-name 'INSTALL*'	-o \
		-name 'README*'		-o \
		-name 'Change*'	\) -exec gzip -9 \{\} \;
}
