# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/xmms/xmms-1.2.10-r15.ebuild,v 1.7 2005/08/13 23:18:56 hansmi Exp $

inherit flag-o-matic eutils libtool gnuconfig

PATCH_VER="2.3.0"
M4_VER="1.1"

PATCHDIR="${WORKDIR}/patches"

DESCRIPTION="X MultiMedia System"
HOMEPAGE="http://www.xmms.org/"
SRC_URI="http://www.xmms.org/files/1.2.x/${P}.tar.bz2
	mirror://gentoo/gentoo_ice-xmms-0.2.tar.bz2
	http://dev.gentoo.org/~eradicator/xmms/${P}-gentoo-m4-${M4_VER}.tar.bz2
	http://dev.gentoo.org/~eradicator/xmms/${P}-gentoo-patches-${PATCH_VER}.tar.bz2
	http://dev.gentoo.org/~eradicator/xmms/gnomexmms.xpm"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~mips ppc ppc64 sparc x86"
IUSE="nls esd mmx vorbis 3dnow mikmod directfb alsa oss arts jack sndfile lirc flac mad mp3"

DEPEND="=x11-libs/gtk+-1.2*"

RDEPEND="${DEPEND}
	directfb? ( dev-libs/DirectFB )
	app-arch/unzip"

#We want these things in DEPEND only
DEPEND="${DEPEND}
	>=sys-devel/automake-1.9
	>=sys-devel/autoconf-2.5
	sys-devel/libtool
	nls? ( dev-util/intltool
	       dev-lang/perl
	       sys-devel/gettext )"

# USE flags pull in xmms plugins
PDEPEND="lirc? ( media-plugins/xmms-lirc )

	 flac? ( media-libs/flac )
	 mikmod? ( media-plugins/xmms-mikmod )
	 mp3? ( mad? ( >=media-plugins/xmms-mad-0.7 )
	        >=media-plugins/xmms-mpg123-1.2.10-r1 )
	 vorbis? ( >=media-plugins/xmms-vorbis-1.2.10-r1 )
	 sndfile? ( media-plugins/xmms-sndfile )

	 alsa? ( media-plugins/xmms-alsa )
	 arts? ( media-plugins/xmms-arts )
	 jack? ( media-plugins/xmms-jack )
	 esd? ( media-plugins/xmms-esd )
	 oss? ( media-plugins/xmms-oss )"

src_unpack() {
	if ! has_version '>=sys-devel/gettext-0.14.1'; then
		eerror "Sorry, you seem to have USE=-nls with an old version of gettext"
		eerror "on your system.  Unfortunately, that will cause xmms to fail emerging."
		eerror "Please either remove gettext or upgrade to version 0.14.1."
	fi

	unpack ${A}
	cd ${S}

	EPATCH_SUFFIX="patch"
	epatch ${PATCHDIR}

	export WANT_AUTOMAKE=1.9
	export WANT_AUTOCONF=2.5

	sed -i 's:Output Input Effect General Visualization::' Makefile.am

	for dir in . libxmms; do
		cd ${S}/${dir}
		rm acinclude.m4
		libtoolize --force --copy || die "libtoolize --force --copy failed"
		[ ! -f ltmain.sh ] && ln -s ../ltmain.sh
		aclocal -I ${WORKDIR}/m4 || die "aclocal failed"
		autoheader || die "autoheader failed"
		automake --gnu --add-missing --include-deps --force-missing --copy || die "automake failed"
		autoconf || die "autoconf failed"
	done

	if use nls; then
		cd ${S}/po
		cp ${FILESDIR}/po-update.pl update.pl
		perl update.pl --pot
	fi

	cd ${S}
	gnuconfig_update
}

src_compile() {
	export EGREP="grep -E"
	filter-flags -fforce-addr -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE

	local myconf=""

	if use !amd64 && { use 3dnow || use mmx; }; then
		myconf="${myconf} --enable-simd"
	else
		myconf="${myconf} --disable-simd"
	fi

	# Please see Bug 58092 for details
	use ppc64 && replace-flags "-O[2-9]" "-O1"

	econf `use_enable nls` ${myconf} || die

	# For some reason, gmake doesn't export this for libtool's consumption
	emake -j1 || die
}

src_install() {
	export EGREP="grep -E"
	make DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog FAQ NEWS README TODO
	newdoc ${PATCHDIR}/README README.patches
	newdoc ${PATCHDIR}/ChangeLog ChangeLog.patches

	keepdir /usr/share/xmms/Skins
	insinto /usr/share/pixmaps/
	newins ${DISTDIR}/gnomexmms.xpm xmms.xpm
	doins xmms/xmms_logo.xpm
	insinto /usr/share/pixmaps/mini
	doins xmms/xmms_mini.xpm

	insinto /etc/X11/wmconfig
	donewins xmms/xmms.wmconfig xmms

	insinto /usr/share/applications
	doins ${FILESDIR}/xmms.desktop

	# Add the sexy Gentoo Ice skin
	insinto /usr/share/xmms/Skins/gentoo_ice
	doins ${WORKDIR}/gentoo_ice/*
	docinto gentoo_ice
	dodoc ${WORKDIR}/README

	insinto /usr/include/xmms/libxmms
	doins ${S}/libxmms/*.h

	insinto /usr/include/xmms
	doins ${S}/xmms/i18n.h
}

pkg_postinst() {
	einfo "media-sound/xmms now just provides the xmms binary and libxmms."
	einfo "All plugins that were packaged with xmms are now provided by other"
	einfo "packages in media-plugins.  Some of these are automatically pulled in"
	einfo "based on USE flags.  Others you will need to emerge manually.  The"
	einfo "following is a list of packages which were previously provided by"
	einfo "media-sound/xmms that are not automatically emerged:"
	einfo "media-plugins/xmms-blur-scope"
	einfo "media-plugins/xmms-cdaudio"
	einfo "media-plugins/xmms-disk-writer"
	einfo "media-plugins/xmms-echo"
	einfo "media-plugins/xmms-ir"
	einfo "media-plugins/xmms-joystick"
	einfo "media-plugins/xmms-opengl-spectrum"
	einfo "media-plugins/xmms-sanalyzer"
	einfo "media-plugins/xmms-song-change"
	einfo "media-plugins/xmms-stereo"
	einfo "media-plugins/xmms-tonegen"
	einfo "media-plugins/xmms-voice"
	einfo "media-plugins/xmms-wav"
}
