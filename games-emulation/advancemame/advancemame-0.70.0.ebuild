# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/advancemame/advancemame-0.70.0.ebuild,v 1.4 2004/01/06 03:53:00 mr_bones_ Exp $

inherit eutils

# This build we configure to explicitly use SDL, as it is very
# difficult to get it working with fb or svgalib support.  Anyway,
# it do not look as good ;-)

ADVMNU_VER="2.2.7"

MY_PV="$(echo ${PV} | cut -d. -f1,2)"
S="${WORKDIR}/advmame"
DESCRIPTION="GNU/Linux port of the MAME emulator, with GUI menu."
SRC_URI="mirror://sourceforge/advancemame/${P}.tar.gz
	mirror://sourceforge/advancemame/advancemenu-${ADVMNU_VER}.tar.gz
	http://mbnet.fi/~gridle/mame${MY_PV/\.}s.zip
	http://www.mame.net/zips/mame${MY_PV/\.}s.zip
	http://roms.mame.dk/emu/mame${MY_PV/\.}s.zip"
HOMEPAGE="http://advancemame.sourceforge.net/"

LICENSE="GPL-2 xmame"
SLOT="0"
KEYWORDS="~x86"

RDEPEND="virtual/glibc
	app-arch/unzip
	>=dev-lang/nasm-0.98
	>=media-libs/libsdl-1.2.3
	slang? ( sys-libs/slang )
	svga? ( >=media-libs/svgalib-1.9 )"
DEPEND="${RDEPEND}
	sys-kernel/linux-headers"

src_unpack() {
	unpack ${A}

	mkdir -p ${S}

	cd ${S}
	# Unpack mame and advacemame
	unzip -qaa ${WORKDIR}/mame.zip || die
	cp -adf ${WORKDIR}/${P}/* .
	cp -adf ${WORKDIR}/advancemenu-${ADVMNU_VER}/* .

	# This one is from MAME.ZIP, and breaks things if present
	rm -f makefile

	cd ${S}/src
	# Apply the advancemame patch to the mame sources
	epatch  ../advance/advmame.dif

	for x in os.c vslang.c
	do
		cp -f ${S}/advance/linux/${x} ${S}/advance/linux/${x}.orig
		sed -e 's:slang/slang.h:slang.h:' \
			${S}/advance/linux/${x}.orig > ${S}/advance/linux/${x}
		rm -f ${S}/advance/linux/${x}.orig
	done

	# Fix manpage/doc install location
	cp -f ${S}/advance/advance.mak ${S}/advance/advance.mak.orig
	sed -e 's:$(PREFIX)/doc/advance:$(PREFIX)/share/doc/$(PF):g' \
	    -e 's:$(PREFIX)/man/man1:$(PREFIX)/share/man/man1:g' \
	    ${S}/advance/advance.mak.orig > ${S}/advance/advance.mak
	rm -f ${S}/advance/advance.mak.orig
}

src_compile() {
	local myconf=

	use fbcon || myconf="${myconf} --disable-fb"

	use oss || myconf="${myconf} --disable-oss"

	use alsa || myconf="${myconf} --disable-alsa"

	use slang || myconf="${myconf} --disable-slang"

	use svga || myconf="${myconf} --disable-svgalib"

	# Configure with explicit SDL support
	# NOTE: do not use econf, as we should not
	#       pass --host ...
	./configure \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--with-system=sdl \
		--enable-pthread \
		${myconf} || die

	emake || die
}

src_install() {
	# The install script do not create this one
	dodir /usr/bin
	make PREFIX=${D}/usr install || die

	dodir /usr/share/advance/{artwork,diff,image,rom,sample,snap}

	dodoc COPYING HISTORY README RELEASE whatsnew.txt
	dodoc docs/{ctrlr.txt,listinfo.txt,mame.txt}
	# Zip the docs that was installed by 'make install'
	gzip ${D}/usr/share/doc/${PF}/*.txt

	# Move the html pages the the correct location
	dodir /usr/share/doc/${PF}/html
	mv -f ${D}/usr/share/doc/${PF}/*.html ${D}/usr/share/doc/${PF}/html
}

