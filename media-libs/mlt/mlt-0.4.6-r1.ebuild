# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/mlt/mlt-0.4.6-r1.ebuild,v 1.2 2009/11/26 21:17:13 mr_bones_ Exp $

EAPI="2"

inherit kde-functions eutils toolchain-funcs multilib python

DESCRIPTION="An open source multimedia framework, designed and developed for television broadcasting"
HOMEPAGE="http://mlt.sourceforge.net/"
SRC_URI="mirror://sourceforge/mlt/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE="compressed-lumas dv debug ffmpeg frei0r gtk jack kde libsamplerate melt
mmx qt4 quicktime sdl sse vorbis xine xml lua python ruby" # java perl php tcl

RDEPEND="ffmpeg? ( >=media-video/ffmpeg-0.4.9_p20080326 )
	dv?	( >=media-libs/libdv-0.104 )
	xml?	( >=dev-libs/libxml2-2.5 )
	vorbis?	( >=media-libs/libvorbis-1.1.2 )
	sdl?	( >=media-libs/libsdl-1.2.10
		  >=media-libs/sdl-image-1.2.4 )
	libsamplerate? ( >=media-libs/libsamplerate-0.1.2 )
	jack?	( media-sound/jack-audio-connection-kit
			  media-libs/ladspa-sdk
			  >=dev-libs/libxml2-2.5 )
	frei0r? ( media-plugins/frei0r-plugins )
	gtk?	( x11-libs/gtk+:2
		  x11-libs/pango )
	quicktime? ( media-libs/libquicktime )
	xine? ( >=media-libs/xine-lib-1.1.2_pre20060328-r7 )
	qt4? ( x11-libs/qt-gui:4 )
	!media-libs/mlt++
	lua? ( >=dev-lang/lua-5.1.4-r4 )
	python? ( dev-lang/python )
	ruby? ( dev-lang/ruby )
	"
#	sox? ( media-sound/sox )
#	java? ( >=virtual/jre-1.5 )
#	perl? ( dev-lang/perl )
#	php? ( dev-lang/php )
#	tcl? ( dev-lang/tcl )

SWIG_DEPEND=">=dev-lang/swig-1.3.38"
DEPEND="${RDEPEND}
	compressed-lumas? ( media-gfx/imagemagick )
	lua? ( ${SWIG_DEPEND} dev-util/pkgconfig )
	python? ( ${SWIG_DEPEND} )
	ruby? ( ${SWIG_DEPEND} )
	"
#	java? ( ${SWIG_DEPEND} >=virtual/jdk-1.5 )
#	perl? ( ${SWIG_DEPEND} )
#	php? ( ${SWIG_DEPEND} )
#	tcl? ( ${SWIG_DEPEND} )

#pkg_setup() {
#    local fail="USE sox needs also USE libsamplerate enabled."
#
#    if use sox && ! use libsamplerate; then
#        eerror "${fail}"
#        die "${fail}"
#    fi
#}

src_configure() {
	tc-export CC CXX

	local myconf="	--enable-gpl
		--enable-motion-est
		$(use_enable debug)
		$(use_enable dv)
		$(use_enable sse)
		$(use_enable gtk gtk2)
		$(use_enable vorbis)
		$(use_enable sdl)
		$(use_enable jack jackrack)
		$(use_enable ffmpeg avformat)
		$(use_enable frei0r)
		$(use_enable melt)
		$(use_enable libsamplerate resample)
		$(use_enable xml)
		$(use_enable xine)
		$(use_enable kde kdenlive)
		$(use_enable qt4 qimage)
		--disable-sox"
		#$(use_enable sox)  FIXME

	use ffmpeg && myconf="${myconf} --avformat-swscale"

	(use quicktime && use dv) ||  myconf="${myconf} --disable-kino"

	use compressed-lumas && myconf="${myconf} --luma-compress"

	( use x86 || use amd64 ) && \
		myconf="${myconf} $(use_enable mmx)" ||
		myconf="${myconf} --disable-mmx"

	use melt || sed -i -e "s;src/melt;;" Makefile

	# TODO: add swig language bindings
	# see also http://www.mltframework.org/twiki/bin/view/MLT/ExtremeMakeover

	local swig_lang
	# TODO: java perl php tcl
	for i in lua python ruby ; do
		use $i && swig_lang="${swig_lang} $i"
	done
	[ -z "${swig_lang}" ] && swig_lang="none"

	econf ${myconf} --swig-languages="${swig_lang}"
	sed -i -e s/^OPT/#OPT/ "${S}/config.mak"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc docs/*.txt ChangeLog README docs/TODO

	dodir /usr/share/${PN}
	insinto /usr/share/${PN}
	doins -r demo

	docinto swig

	# Install SWIG bindings
	if use lua; then
		cd "${S}"/src/swig/lua
		exeinto $(pkg-config --variable INSTALL_CMOD lua)
		doexe mlt.so
		dodoc play.lua
	fi

	if use python; then
		python_version
		cd "${S}"/src/swig/python
		insinto /usr/$(get_libdir)/python${PYVER}/site-packages
		doins mlt.py
		exeinto /usr/$(get_libdir)/python${PYVER}/site-packages
		doexe _mlt.so
		dodoc play.py
	fi

	if use ruby; then
		cd "${S}"/src/swig/ruby
		exeinto $(/usr/bin/ruby -r rbconfig -e 'print Config::CONFIG["sitearchdir"]')
		doexe mlt.so
		dodoc play.rb thumbs.rb
	fi
	# TODO: java perl php tcl
}
