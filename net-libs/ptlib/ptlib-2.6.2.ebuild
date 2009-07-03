# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/ptlib/ptlib-2.6.2.ebuild,v 1.1 2009/07/03 09:57:10 volkmar Exp $

EAPI="2"

inherit eutils

DESCRIPTION="Network focused portable C++ class library providing high level functions"
HOMEPAGE="http://www.opalvoip.org/"
SRC_URI="mirror://sourceforge/opalvoip/${P}.tar.bz2
	doc? ( mirror://sourceforge/opalvoip/${P}-htmldoc.tar.bz2 )"

LICENSE="MPL-1.0"
SLOT="0"
KEYWORDS="~ppc ~x86"
# default enabled are features from 'minsize', the most used according to ptlib
IUSE="alsa +asn +audio config-file debug dns doc dtmf esd examples ffmpeg ftp
+http http-forms http-server ieee1394 ipv6 jabber ldap mail pipechan odbc oss
pch qos remote sasl sdl serial shmvideo snmp soap socks ssl +stun telnet tts
+url v4l v4l2 +video video-file vxml wav xml xmlrpc"

COMMON_DEP="audio? ( alsa? ( media-libs/alsa-lib )
		esd? ( media-sound/esound ) )
	ldap? ( net-nds/openldap )
	odbc? ( dev-db/unixODBC )
	sasl? ( dev-libs/cyrus-sasl:2 )
	sdl? ( media-libs/libsdl )
	ssl? ( dev-libs/openssl )
	video? ( ieee1394? ( media-libs/libdc1394:1
				media-libs/libdv
				sys-libs/libavc1394
				sys-libs/libraw1394 )
		v4l2? ( media-libs/libv4l ) )
	xml? ( dev-libs/expat )"
RDEPEND="${COMMON_DEP}
	ffmpeg? ( media-video/ffmpeg )"
DEPEND="${COMMON_DEP}
	dev-util/pkgconfig
	sys-devel/bison
	sys-devel/flex
	video? ( v4l? ( sys-kernel/linux-headers )
		v4l2? ( sys-kernel/linux-headers ) )
	!!dev-libs/pwlib"

# NOTES:
# media-libs/libdc1394:2 should be supported but headers location have changed
# tools/ directory is ignored
# looks to have an auto-magic dep with medialibs, but not in the tree so...
#	upstream bug 2794736

# TODO:
# manage in a better way the conditional use flags (with eapi-3 ?)

conditional_use_error_msg() {
	eerror "To enable ${1} USE flag, you need ${2} USE flag to be enabled"
	eerror "Please, enable ${2} or disable ${1}"
}

pkg_setup() {
	local use_error=false

	# stop emerge if a conditional use flag is not respected

	if ! use video; then
		if use sdl; then
			conditional_use_error_msg "sdl" "video"
			use_error=true
		fi
		if use video-file; then
			conditional_use_error_msg "video-file" "video"
			use_error=true
		fi
	fi

	if use jabber && ! use xml; then
		conditional_use_error_msg "jabber" "xml"
		use_error=true
	fi

	if use ldap && ! use dns; then
		conditional_use_error_msg "ldap" "dns"
		use_error=true
	fi

	if use ffmpeg && ! use pipechan; then
		conditional_use_error_msg "ffmpeg" "pipechan"
		use_error=true
	fi

	if use http && ! use url; then
		conditional_use_error_msg "http" "url"
		use_error=true
	fi

	if use http-forms; then
		if ! use http; then
			conditional_use_error_msg "http-forms" "http"
			use_error=true
		fi
		if ! use config-file; then
			conditional_use_error_msg "http-forms" "config-file"
			use_error=true
		fi
	fi

	if use http-server && ! use http-forms; then
		conditional_use_error_msg "http-server" "http-forms"
		use_error=true
	fi

	if use vxml; then
		if ! use xml; then
			conditional_use_error_msg "vxml" "xml"
			use_error=true
		fi
		if ! use http; then
			conditional_use_error_msg "vxml" "http"
			use_error=true
		fi
	fi

	if use xmlrpc; then
		if ! use xml; then
			conditional_use_error_msg "xmlrpc" "xml"
			use_error=true
		fi
		if ! use http; then
			conditional_use_error_msg "xmlrpc" "http"
			use_error=true
		fi
	fi

	if use soap; then
		if ! use xml; then
			conditional_use_error_msg "soap" "xml"
			use_error=true
		fi
		if ! use http; then
			conditional_use_error_msg "soap" "http"
			use_error=true
		fi
	fi

	if ${use_error}; then
		echo
		eerror "Please see messages above and re-emerge ${PN} accordingly."
		die
	fi
}

src_prepare() {
	# move files from doc tarball into ${S}
	if use doc; then
		mv ../html . || die "moving doc files failed"
	fi

	# remove visual studio related files from samples/
	if use examples; then
		rm -f samples/*/*.vcproj
		rm -f samples/*/*.sln
		rm -f samples/*/*.dsp
		rm -f samples/*/*.dsw
	fi

	# workaround for a compilation issue in contain.cxx, upstream bug 2794741
	epatch "${FILESDIR}"/${P}-gcc-allocator.patch
}

src_configure() {
	local myconf=""

	# plugins are disabled only if ! audio and ! video
	if ! use audio && ! use video; then
		myconf="${myconf} --disable-plugins"
	else
		myconf="${myconf} --enable-plugins"
	fi

	# minsize, openh323, opal: presets of features (overwritten by use flags)
	# ansi-bool, atomicity: there is no reason to disable those features
	# internalregex: we want to use system one
	# sunaudio and bsdvideo are respectively for SunOS and BSD's
	# appshare, vfw: only for windows
	# sockagg: not used anymore, upstream bug 2794755
	# samples: no need to build samples
	econf ${myconf} \
		--disable-minsize \
		--disable-openh323 \
		--disable-opal \
		--enable-ansi-bool \
		--enable-atomicity \
		--disable-internalregex \
		--disable-sunaudio \
		--disable-bsdvideo \
		--disable-appshare \
		--disable-vfw \
		--disable-sockagg \
		--disable-samples \
		$(use_enable audio) \
		$(use_enable alsa) \
		$(use_enable asn) \
		$(use_enable config-file configfile) \
		$(use_enable debug exceptions) \
		$(use_enable debug memcheck) \
		$(use_enable debug tracing) \
		$(use_enable dns resolver) \
		$(use_enable dtmf) \
		$(use_enable esd) \
		$(use_enable ffmpeg ffvdev) \
		$(use_enable ftp) \
		$(use_enable http) \
		$(use_enable http-forms httpforms) \
		$(use_enable http-server httpsvc) \
		$(use_enable ieee1394 avc) \
		$(use_enable ieee1394 dc) \
		$(use_enable ipv6) \
		$(use_enable jabber) \
		$(use_enable ldap openldap) \
		$(use_enable mail pop3smtp) \
		$(use_enable odbc) \
		$(use_enable oss) \
		$(use_enable pch) \
		$(use_enable pipechan) \
		$(use_enable qos) \
		$(use_enable remote remconn) \
		$(use_enable sasl) \
		$(use_enable sdl) \
		$(use_enable serial) \
		$(use_enable shmvideo) \
		$(use_enable snmp) \
		$(use_enable soap) \
		$(use_enable socks) \
		$(use_enable ssl openssl) \
		$(use_enable stun) \
		$(use_enable telnet) \
		$(use_enable tts) \
		$(use_enable url) \
		$(use_enable v4l) \
		$(use_enable v4l2) \
		$(use_enable video) \
		$(use_enable video-file vidfile) \
		$(use_enable vxml) \
		$(use_enable wav wavfile) \
		$(use_enable xml expat) \
		$(use_enable xmlrpc)
}

src_compile() {
	local makeopts=""

	use debug && makeopts="debug"

	emake ${makeopts} || die "emake failed"
}

src_install() {
	local makeopts=""

	use debug && makeopts="DEBUG=1"

	emake DESTDIR="${D}" ${makeopts} install || die "emake install failed"

	if use doc; then
		dohtml -r html/* || die "dohtml failed"
	fi

	dodoc History.txt ReadMe.txt ReadMe_QOS.txt || die "dodoc failed"

	# ChangeLog is not standard
	dodoc ChangeLog-${PN}-v${PV//./_}.txt || die "dodoc failed"

	if use examples; then
		local exampledir="/usr/share/doc/${PF}/examples"
		local basedir="samples"
		local sampledirs="`ls samples --hide=Makefile`"

		# first, install Makefile
		insinto ${exampledir}/
		doins ${basedir}/Makefile || die "doins failed"

		# now, all examples
		for x in ${sampledirs}; do
			insinto ${exampledir}/${x}/
			doins ${basedir}/${x}/* || die "doins failed"
		done
	fi
}

pkg_postinst() {
	if use examples; then
		ewarn "All examples have been installed, some of them will not work on your system"
		ewarn "it will depend of the enabled USE flags."
		ewarn "To test examples, you have to run PTLIBDIR=/usr/share/ptlib make"
	fi

	if ! use audio || ! use video; then
		ewarn "You have disabled audio or video USE flags."
		ewarn "Most audio/video have been disabled silently even if enabled via USE flags."
		ewarn "Having a feature enabled via use flag but disabled can lead to issues."
	fi

	ewarn "If you've just removed pwlib to install ptlib, some packages will be broken."
	ewarn "Please use 'revdep-rebuild' from app-portage/gentoolkit to check."
	ewarn "If some packages need pwlib, consider removing ptlib and re-installing pwlib"
	ewarn "or help us to make them live together."
}
