# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/advancemame/advancemame-0.61.1.ebuild,v 1.2 2004/01/06 03:53:00 mr_bones_ Exp $

# This build we configure to explicitly use SDL, as it is very
# difficult to get it working with fb or svgalib support.  Anyway,
# it do not look as good ;-)

# Snapshot support
SNAPSHOT="20020824"

MY_PV="$(echo ${PV} | cut -d. -f1,2)"
S="${WORKDIR}/advmame"
DESCRIPTION="GNU/Linux port of the MAME emulator, with GUI menu."
# Handle snapshots differently
if [ -z "${SNAPSHOT}" ] ; then
	SRC_URI="mirror://sourceforge/advancemame/${P}.zip"
	MY_A="${P}.zip"
else
	SRC_URI="mirror://gentoo/${PN}-${SNAPSHOT}.tar.bz2"
	MY_A="${PN}-${SNAPSHOT}.tar.bz2"
fi
SRC_URI="${SRC_URI}
	http://mbnet.fi/~gridle/mame${MY_PV/\.}s.zip
	http://www.mame.net/zips/mame${MY_PV/\.}s.zip
	http://roms.mame.dk/emu/mame${MY_PV/\.}s.zip"
HOMEPAGE="http://advancemame.sourceforge.net/"

LICENSE="GPL-2 xmame"
SLOT="0"
KEYWORDS="x86 -ppc"

DEPEND="virtual/x11
	app-arch/unzip
	>=dev-lang/nasm-0.98
	>=media-libs/libsdl-1.2.3"

src_unpack() {
	unpack mame${MY_PV/\.}s.zip

	mkdir -p ${S}

	cd ${S}
	# Unpack mame and advacemame
	unzip -aa ${WORKDIR}/MAME.ZIP || die
	# Handle snapshots differently
	if [ -z "${SNAPSHOT}" ] ; then
		unzip -aa -o ${DISTDIR}/${P}.zip || die
	else
		tar -jxf ${DISTDIR}/${PN}-${SNAPSHOT}.tar.bz2 || die
	fi

	# This one is from MAME.ZIP, and breaks things if present
	rm -f makefile

	cd ${S}/src
	# Apply the advancemame patch to the mame sources
	patch -p1 < ../advance/advmame.dif || die

	# Fix manpage/doc install location
	cp ${S}/advance/advance.mak ${S}/advance/advance.mak.orig
	sed -e 's:$(PREFIX)/doc/advance:$(PREFIX)/share/doc/$(PF):g' \
	    -e 's:$(PREFIX)/man/man1:$(PREFIX)/share/man/man1:g' \
	    ${S}/advance/advance.mak.orig > ${S}/advance/advance.mak
}

src_compile() {
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

	dodoc COPYING whatsnew.txt
	dodoc docs/{ctrlr.txt,listinfo.txt,mame.txt}
	# Zip the docs that was installed by 'make install'
	gzip ${D}/usr/share/doc/${PF}/*.txt

	# Move the html pages the the correct location
	dodir /usr/share/doc/${PF}/html
	mv ${D}/usr/share/doc/${PF}/*.html ${D}/usr/share/doc/${PF}/html
}
