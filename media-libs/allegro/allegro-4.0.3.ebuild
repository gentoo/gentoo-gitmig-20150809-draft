# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/allegro/allegro-4.0.3.ebuild,v 1.7 2004/03/19 07:56:03 mr_bones_ Exp $

inherit flag-o-matic

DESCRIPTION="cross-platform multimedia library"
SRC_URI="mirror://sourceforge/alleg/${P}.tar.gz"
HOMEPAGE="http://alleg.sourceforge.net/"

LICENSE="Allegro"
SLOT="0"
KEYWORDS="x86 sparc"
IUSE="static mmx sse oss alsa esd arts X fbcon svga tetex"

RDEPEND="alsa? ( media-libs/alsa-lib )
	esd? ( media-sound/esound )
	arts? ( kde-base/arts )
	X? ( virtual/x11 )
	svga? ( media-libs/svgalib )"
DEPEND="${RDEPEND}
	tetex? ( virtual/tetex )"

src_unpack() {
	unpack ${A}
	sed -i '/TARGET_ARCH=/s:=.*:=:' ${S}/configure || die 'couldnt remove pentium cpu'
}

src_compile() {
	filter-flags -fPIC
	econf \
		--enable-linux \
		--enable-vga \
		`use_enable static` \
		`use_enable static staticprog` \
		`use_enable mmx` \
		`use_enable sse` \
		`use_enable oss ossdigi` \
		`use_enable oss ossmidi` \
		`use_enable alsa alsadigi` \
		`use_enable alsa alsamidi` \
		`use_enable esd esddigi` \
		`use_enable arts artsdigi` \
		`use_with X x` \
		`use_enable X xwin-shm` \
		`use_enable X xwin-vidmode` \
		`use_enable X xwin-dga` \
		`use_enable X xwin-dga2` \
		`use_enable fbcon` \
		`use_enable svga svgalib` \
		|| die

	cp makefile{,.orig}
	sed -e "/CFLAGS =.*/s:$: ${CFLAGS}:" \
		makefile.orig > makefile
	make || die	# emake fails

	if [ `use tetex` ] ; then
		addwrite /var/lib/texmf
		addwrite /usr/share/texmf
		addwrite /var/cache/fonts
		make docs-dvi docs-ps || die
	fi
}

src_install() {
	addpredict /usr/share/info
	make DESTDIR=${D} install install-gzipped-man install-gzipped-info || die

	# Different format versions of the Allegro documentation
	dodoc AUTHORS CHANGES THANKS readme.txt todo.txt
	[ `use tetex` ] && dodoc docs/allegro.{dvi,ps}
	dohtml docs/html/*
	docinto txt ; dodoc docs/txt/*.txt
	docinto rtf ; dodoc docs/rtf/*.rtf
	docinto build ; dodoc docs/build/*.txt
}
