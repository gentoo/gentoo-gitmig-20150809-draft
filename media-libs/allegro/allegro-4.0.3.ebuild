# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/allegro/allegro-4.0.3.ebuild,v 1.1 2003/04/25 13:42:25 vapier Exp $

inherit flag-o-matic

DESCRIPTION="cross-platform multimedia library"
SRC_URI="mirror://sourceforge/alleg/${P}.tar.gz"
HOMEPAGE="http://alleg.sourceforge.net/"

LICENSE="Allegro"
SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE="mmx esd static tetex X fbcon oss svga alsa"

RDEPEND="X? ( virtual/x11 )
	alsa? ( media-libs/alsa-lib )
	esd? ( media-sound/esound )
	svga? ( media-libs/svgalib )"
DEPEND="${RDEPEND}
	tetex? ( app-text/tetex )"

src_compile() {
	# Always enable Linux console support and accompanying drivers
	confopts="${confopts} --enable-linux --enable-vga"
	
	# if USE static defined, use static library as default to link with
	use static \
		&& confopts="${confopts} --enable-staticprog --enable-static"
	
	# Pentium optimizations
	if [ ${CHOST} = "i586-pc-linux-gnu" -o ${CHOST} = "i686-pc-linux-gnu" ]
	then 
		confopts="${confopts} --enable-pentiumopts"
	fi
	
	# Use MMX instructions
	use mmx \
		&& confopts="${confopts} --enable-mmx" \
		|| confopts="${confopts} --enable-mmx=no"
	
	# Have OSS support
	use oss \
		&& confopts="${confopts} --enable-ossdigi --enable-ossmidi" \
		|| confopts="${confopts} --disable-ossdigi --disable-ossmidi"
	
	# Have ALSA support
	use alsa \
		&& confopts="${confopts} --enable-alsadigi --enable-alsamidi" \
		|| confopts="${confopts} --disable-alsadigi --disable-alsamidi"
	
	# Have ESD support
	use esd \
		&& confopts="${confopts} --enable-esddigi" \
		|| confopts="${confopts} --disable-esddigi"
	
	# Have X11 support
	use X \
		&& confopts="${confopts} \
			--with-x \
			--enable-xwin-shm \
			--enable-xwin-vidmode \
			--enable-xwin-dga \
			--enable-xwin-dga2" \
		|| confopts="${confopts} \
			--without-x \
			--disable-xwin-shm \
			--disable-xwin-vidmode \
			--disable-xwin-dga \
			--disable-xwin-dga2"
	
	# Have SVGALib support
	use svga \
		&& confopts="${confopts} --enable-svgalib" \
		|| confopts="${confopts} --disable-svgalib"
	
	# Have fbcon support
	use fbcon \
		&& confopts="${confopts} --enable-fbcon" \
		|| confopts="${confopts} --disable-fbcon"

	# --------------

	econf ${confopts} || die
	
	# emake doesn't work
	filter-flags -fPIC
	make CFLAGS="${CFLAGS/-fPIC/}" || die
	
	if use tetex;
	then
		addwrite "/var/lib/texmf"
		addwrite "/usr/share/texmf"
		addwrite "/var/cache/fonts"
		make docs-dvi docs-ps || die
	fi
	
}

src_install() {
	make \
		prefix=${D}/usr \
		infodir=${D}/usr/share/info \
		mandir=${D}/usr/share/man \
		install install-gzipped-man install-gzipped-info || die
	
	# Different format versions of the Allegro documentation

	dodoc AUTHORS CHANGES THANKS readme.txt todo.txt

	if use tetex;
	then 
		dodoc docs/allegro.dvi docs/allegro.ps
	fi

	dohtml docs/html/*

	docinto txt
	dodoc docs/txt/*.txt

	docinto rtf
	dodoc docs/rtf/*.rtf
	
	docinto build
	dodoc docs/build/*.txt
}
