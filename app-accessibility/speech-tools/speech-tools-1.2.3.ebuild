# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/speech-tools/speech-tools-1.2.3.ebuild,v 1.4 2004/03/25 17:25:30 gustavoz Exp $

inherit eutils fixheadtails

MY_P=${P/-/_}
DESCRIPTION="Speech tools for Festival Text to Speech engine"
HOMEPAGE="http://www.cstr.ed.ac.uk/"
SRC_URI="http://www.cstr.ed.ac.uk/download/festival/1.4.3/${MY_P}-release.tar.gz
	 doc? ( http://www.cstr.ed.ac.uk/download/festival/1.4.3/festdoc-1.4.2.tar.gz )"

LICENSE="FESTIVAL BSD as-is"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc amd64"

RDEPEND="virtual/glibc"
IUSE=""
S="${WORKDIR}/speech_tools"

src_unpack() {
	unpack ${MY_P}-release.tar.gz

	cd ${S}
	use doc && unpack festdoc-1.4.2.tar.gz && mv festdoc-1.4.2 festdoc

	epatch ${FILESDIR}/${PN}-gcc3.3.diff
	ht_fix_file config.guess
	sed -i 's:-O3:$(CFLAGS):' base_class/Makefile
	sed -i 's/-fno-implicit-templates //' config/compilers/gcc_defaults.mak

	# Compile fix for #41329.
	[ `use sparc` ] && sed -i 's/-fpic/-fPIC/' config/compilers/gcc_defaults.mak
}

src_install() {
	into /usr/lib/speech-tools

	cd ${S}/bin
	rm -f Makefile

	dodir /usr/lib/speech-tools/share/testsuite
	for file in *; do
		dobin ${file}
		dosed "s:${S}/testsuite/data:/usr/lib/speech-tools/share/testsuite:g" /usr/lib/speech-tools/bin/${file} testsuite/data
		dosed "s:${S}/bin:/usr/lib/speech-tools/bin:g" /usr/lib/speech-tools/bin/${file}
		dosed "s:${S}/main:/usr/lib/speech-tools/bin:g" /usr/lib/speech-tools/bin/${file}
		dosed "s:${S}/lib:/usr/lib/speech-tools/lib:g" /usr/lib/speech-tools/bin/${file}
	done

	cd ${S}/lib
	dolib.so libestbase.so.1.2.3.1
	dosym /usr/lib/speech-tools/lib/libestbase.so.1.2.3.1 /usr/lib/speech-tools/lib/libestbase.so
	dolib.so libeststring.so.1.2
	dosym /usr/lib/speech-tools/lib/libeststring.so.1.2 /usr/lib/speech-tools/lib/libeststring.so
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
	dodoc README INSTALL
	cd ${S}/lib
	dodoc cstrutt.dtd

	if use doc; then
		cd ${S}/festdoc/speech_tools/doc
		dohtml *
	fi
}
