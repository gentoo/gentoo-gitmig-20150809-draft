# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/speech-tools/speech-tools-1.2.3.ebuild,v 1.4 2004/02/12 06:04:04 eradicator Exp $

inherit eutils fixheadtails

MY_P=${P/-/_}
DESCRIPTION="Speech tools for Festival Text to Speech engine"
HOMEPAGE="http://www.cstr.ed.ac.uk/"
SRC_URI="http://www.cstr.ed.ac.uk/download/festival/1.4.3/${MY_P}-release.tar.gz"

LICENSE="FESTIVAL BSD as-is"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc"

RDEPEND="virtual/glibc"

S=${WORKDIR}/speech_tools

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-gcc3.3.diff
	ht_fix_file config.guess
	sed -i 's:-O3:$(CFLAGS):' base_class/Makefile
	[ `use static` ] || sed -i 's/# SHARED=1/SHARED=1/' config/config.in
	sed -i 's/-fno-implicit-templates //' config/compilers/gcc_defaults.mak
}

src_compile() {
	econf || die
	make || die
}

src_install() {
	into /usr/lib/speech-tools

	if [ `use static` ] ; then
		dobin `find main/ -perm +1` `find bin/ -perm +1`
	else
		cd ${S}/bin
		rm -f Makefile
		dobin *
	fi

	cd ${S}/lib
	if [ ! `use static` ] ; then
		dolib.so libestbase.so.1.2.3.1
		dosym /usr/lib/speech-tools/lib/libestbase.so.1.2.3.1 /usr/lib/speech-tools/lib/libestbase.so
		dolib.so libeststring.so.1.2
		dosym /usr/lib/speech-tools/lib/libeststring.so.1.2 /usr/lib/speech-tools/lib/libeststring.so
	fi
	dolib.a libestbase.a
	dolib.a libestools.a
	dolib.a libeststring.a

	insinto /usr/lib/speech-tools/lib/siod
	cd ${S}/lib/siod
	doins *
	insinto /usr/share/doc/${PF}/example_data
	cd ${S}/lib/example_data
	doins *

	cd ${S}
	find config -print | cpio -pmd ${D}/usr/lib/speech-tools
	find include -print | cpio -pmd ${D}/usr/lib/speech-tools

	insinto /etc/env.d
	doins ${FILESDIR}/58speech-tools

	cd ${S}
	dodoc README
	dodoc INSTALL
	cd ${S}/lib
	dodoc cstrutt.dtd
}
