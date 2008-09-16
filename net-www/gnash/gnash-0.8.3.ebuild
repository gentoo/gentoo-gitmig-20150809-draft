# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/gnash/gnash-0.8.3.ebuild,v 1.5 2008/09/16 23:06:16 bluebird Exp $

EAPI=1

inherit autotools nsplugins kde-functions qt3 multilib

set-kdedir 3.5

DESCRIPTION="Gnash is a GNU Flash movie player that supports many SWF v7 features"
HOMEPAGE="http://www.gnu.org/software/gnash"
SRC_URI="mirror://gnu/${PN}/${PV}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="+agg -cairo dbus -fbcon -ffmpeg +gstreamer +gtk +kde +nsplugin -opengl -qt3 -sdl test video_cards_i810"

RDEPEND="
	agg? ( >=x11-libs/agg-2.5 )
	opengl? (
		!agg? (
			virtual/opengl
			gtk? ( x11-libs/gtkglext )
		)
	)
	cairo? (
		!opengl? (
			!agg? (
				x11-libs/cairo
			)
		)
	)

	!agg? ( !cairo? ( !opengl? ( >=x11-libs/agg-2.5 ) ) )
	gtk? (
		x11-libs/gtk+:2
		x11-libs/pango
		dev-libs/glib
		dev-libs/atk
	)
	kde? ( kde-base/kdelibs:3.5 )
	qt3? ( x11-libs/qt:3 )
	sdl? ( media-libs/libsdl )
	!gtk? ( !kde? ( !qt3? ( !sdl? ( !fbcon? (
		x11-libs/gtk+:2
		x11-libs/pango
		dev-libs/glib
		dev-libs/atk
		kde-base/kdelibs:3.5
	) ) ) ) )
	dev-libs/libxml2
	sys-libs/zlib
	media-libs/jpeg
	media-libs/libpng
	net-misc/curl

	ffmpeg? (
		!gstreamer? (
			media-libs/libsdl
			>=media-video/ffmpeg-0.4.9_p20080326
		)
	)

	gstreamer? (
		media-plugins/gst-plugins-ffmpeg
		media-plugins/gst-plugins-mad
	)
	>=dev-libs/boost-1.35.0
	x11-libs/libX11
	x11-libs/libXi
	x11-libs/libXmu
	x11-libs/libXt
	x11-proto/xproto
	dbus? ( sys-apps/dbus )
	sys-devel/libtool
	"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	test? ( dev-util/dejagnu
		media-gfx/swftools
		>=media-libs/ming-0.4.0_beta5 )"

pkg_setup() {
	if use !gtk && use !kde && use !fbcon && use !qt3
	then
		einfo "No Graphical User Interface selected. Enabling kde and gtk"
		einfo "since they are the defaults."
		export defaultguis=1
	fi

	if use !agg && use !opengl && use cairo && use kde
	then
		eerror "The cairo renderer and the kde gui were selected"
		eerror "They are incompatible with each other"
		eerror "Disable one of them through the respective USE flag"
		die "cairo and kde USE flags enabled at the same time"
	fi

	if use !agg && use opengl && use fbcon
	then
		eerror "The opengl renderer and the fbcon gui were selected"
		eerror "They are incompatible with each other"
		eerror "Disable one of them through the respective USE flag"
		die "opengl and fbcon USE flags enabled at the same time"
	fi

	if use nsplugin && use !gtk && [ -z ${defaultguis} ]
	then
		eerror "The Firefox plugin was selected but not the GTK frontend."
		eerror "Disable the nsplugin USE flag or enable the gtk USE flag"
		die "nsplugin USE flag enabled with required gtk USE flag disabled"
	fi

	if use ffmpeg && use gstreamer
	then
		einfo "Only 1 audio output source can be compiled into ${PN}."
		einfo "Selecting gstreamer, since that's upstream default."
		einfo "To enable ffmpeg you must also disable gstreamer."
	fi

	if use agg
	then
		if use opengl || use cairo
		then
			einfo "Only 1 renderer can be activated at any one time."
			einfo "If more than one renderer is activated, the order of preference is:"
			einfo "agg > opengl > cairo"
		fi
	else
		if use !opengl && use !cairo
		then
			einfo "No renderer selected from agg, opengl, cairo"
			einfo "Default renderer agg selected."
		fi
	fi

	if use !ffmpeg && use !gstreamer
	then
		ewarn "You did not select any media: ffmpeg gstreamer"
		ewarn "You will not have sound!"
	fi

}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e 's,config.h,gnashconfig.h,' \
		./extensions/dbus/dbus_ext.h || die
	epatch "${FILESDIR}"/${P}-boost-dynamic-link.patch
	epatch "${FILESDIR}"/${P}-libtool-2.2.patch
	eautoreconf
}

src_compile() {
	local myconf

	if use nsplugin ; then
		myconf="${myconf} --enable-nsapi --with-npapi-plugindir=/opt/netscape/plugins"
	else
		myconf="${myconf} --disable-nsapi"
	fi

#Select renderer.
	if use agg ; then
		myconf="${myconf} --enable-renderer=agg"
	elif use opengl ; then
		myconf="${myconf} --enable-renderer=ogl"
	elif use cairo ; then
		myconf="${myconf} --enable-renderer=cairo"
	else
		myconf="${myconf} --enable-renderer=agg"
	fi

#Select which Graphical User Interfaces to build.
	local	guis="" \
		gui=""
	for gui in fbcon-FB gtk-GTK2 kde-KDE qt3-QT sdl-SDL
	do
		use ${gui/-*} && guis="${guis},${gui/*-}"
	done
	guis=${guis#,}
	if [ -z ${gui} ]
	then
		guis="GTK2,KDE"
	fi

#Select which extensions to build.
	local	extensions="FILEIO" \
		extension=""
	for extension in dbus-DBUS gtk-GTK2 test-DEJAGNU
	do
		use ${extension%-*} && extensions="${extensions},${extension#*-}"
	done

#Select audio output extension.
	if use gstreamer
	then
		myconf="${myconf} --enable-media=gst"
	elif use ffmpeg
	then
		myconf="${myconf} --enable-media=ffmpeg"
	else
		myconf="${myconf} --enable-media=none"
	fi

	econf \
		$(use_enable video_cards_i810 i810-lod-bias) \
		--enable-gui=${guis} \
		--with-extensions=${extensions} \
		--with-ffmpeg-incl=/usr/include \
		--with-kde-pluginprefix=${KDEDIR} \
		--without-included-ltdl \
		--with-ltdl-include=/usr/include \
		--with-ltdl-lib=/usr/lib \
		${myconf} \
		|| die "econf failed"
	emake || die "emake failed"
}

src_test() {
	cd testsuite
	make check || die  "make check failed"
	./anaylse-results.sh > TESTRESULTS.txt
	cat TESTRESULTS.txt
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	if use nsplugin
	then
		emake DESTDIR="${D}" install-plugin \
			|| die "emake install-plugin failed"
		inst_plugin /opt/netscape/plugins/libgnashplugin.so
	else
		rm -rf "${D}/opt"
	fi

	if use kde
	then
		pushd plugin/klash &> /dev/null
		make DESTDIR="${D}" install-plugin
		popd &> /dev/null
	fi

	use test && dodoc testsuite/TESTRESULTS.txt

	dodoc AUTHORS ChangeLog* NEWS README
}

pkg_postinst() {
	ewarn "BETA"
	ewarn "gnash is still in heavy development"
	ewarn "please report gnash bugs upstream to the gnash devs"
	if use test
	then
		ewarn	"Test results can be found in /usr/share/doc/${PF}/TESTRESULTS.txt"
		ewarn	"Currently \"acceptable\" failing tests:"
		ewarn	"Unexpected failures follow:"
		ewarn	" --=[ ./actionscript.all ]=--"
		ewarn	"FAIL: astests-v5-Runner: expected: 584 obtained: 64 [./Date.as:549]"
		ewarn	"FAIL: astests-v5-Runner: expected: 0 obtained: 8 [./Date.as:550]"
		ewarn	"FAIL: astests-v5-Runner: expected: 4 obtained: 45 [./Date.as:551]"
		ewarn	"FAIL: astests-v6-Runner: expected: 584 obtained: 64 [./Date.as:549]"
		ewarn	"FAIL: astests-v6-Runner: expected: 0 obtained: 8 [./Date.as:550]"
		ewarn	"FAIL: astests-v6-Runner: expected: 4 obtained: 45 [./Date.as:551]"
		ewarn	"FAIL: astests-v7-Runner: expected: 584 obtained: 64 [./Date.as:549]"
		ewarn	"FAIL: astests-v7-Runner: expected: 0 obtained: 8 [./Date.as:550]"
		ewarn	"FAIL: astests-v7-Runner: expected: 4 obtained: 45 [./Date.as:551]"
		ewarn	"FAIL: astests-v8-Runner: expected: 584 obtained: 64 [./Date.as:549]"
		ewarn	"FAIL: astests-v8-Runner: expected: 0 obtained: 8 [./Date.as:550]"
		ewarn	"FAIL: astests-v8-Runner: expected: 4 obtained: 45 [./Date.as:551]"
	fi
}
