# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/speech-tools/speech-tools-1.2.3.ebuild,v 1.2 2003/09/07 00:06:06 msterret Exp $

MY_P=${P/-/_}
S=${WORKDIR}/speech_tools
DESCRIPTION="Speech tools for Festival Text to Speech engine"
IUSE=""
HOMEPAGE="http://www.cstr.ed.ac.uk/"
SITE="http://www.cstr.ed.ac.uk/download/festival/1.4.3"
SRC_URI="${SITE}/${MY_P}-release.tar.gz"

SLOT="0"
LICENSE="FESTIVAL BSD as-is"
KEYWORDS="~x86"

RDEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-gcc3.3.diff
}

src_compile() {

	cd ${S}

	if [ ! -n "`use static`" ]
	then
		pushd ${S}/config
		mv -f config.in config.in.orig
		sed -e 's/# SHARED=1/SHARED=1/' config.in.orig > config.in
		popd
	fi

	pushd ${S}/config/compilers
	mv -f gcc_defaults.mak gcc_defaults.mak.orig
	sed -e 's/-fno-implicit-templates //' gcc_defaults.mak.orig > gcc_defaults.mak
	popd

	econf

	make || die

}

src_install() {

	into /usr/lib/speech-tools

	if [ -n "`use static`" ]
	then
		cd ${S}/main
		dobin align
		dobin bcat
		dobin ch_lab
		dobin ch_track
		dobin ch_utt
		dobin ch_wave
		dobin design_filter
		dobin dp
		dobin fringe_client
		dobin na_play
		dobin na_record
		dobin ngram_build
		dobin ngram_test
		dobin ols
		dobin ols_test
		dobin pda
		dobin pitchmark
		dobin scfg_make
		dobin scfg_parse
		dobin scfg_test
		dobin scfg_train
		dobin sig2fv
		dobin sigfilter
		dobin spectgen
		dobin siod
		dobin tilt_analysis
		dobin tilt_synthesis
		dobin viterbi
		dobin wagon
		dobin wagon_test
		dobin wfst_build
		dobin wfst_run
		dobin wfst_train
		dobin xml_parser
		cd ${S}/bin
		dobin build_docbook_index
		dobin cxx_to_docbook
		dobin est_examples
		dobin est_gdb
		dobin est_program
		dobin example_to_doc++
		dobin make_wagon_desc
		dobin pm
		dobin raw_to_xgraph
		dobin resynth
		dobin tex_to_images
	else
		cd ${S}/bin
		rm -f Makefile
		dobin *
	fi

	cd ${S}/lib
	if [ ! -n "`use static`" ]
	then
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

