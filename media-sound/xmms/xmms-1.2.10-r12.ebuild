# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/xmms/xmms-1.2.10-r12.ebuild,v 1.2 2005/02/05 06:24:21 eradicator Exp $

inherit flag-o-matic eutils libtool gnuconfig

PATCHVER="2.2.1"

PATCHDIR="${WORKDIR}/patches"

DESCRIPTION="X MultiMedia System"
HOMEPAGE="http://www.xmms.org/"
SRC_URI="http://www.xmms.org/files/1.2.x/${P}.tar.bz2
	mirror://gentoo/gentoo_ice-xmms-0.2.tar.bz2
	http://dev.gentoo.org/~eradicator/xmms/${P}-gentoo-patches-${PATCHVER}.tar.bz2
	http://dev.gentoo.org/~eradicator/xmms/gnomexmms.xpm"

LICENSE="GPL-2"
SLOT="0"
# alpha was removed because it doesnt satisfy DEPEND.  See bug #66572.
#KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="xml nls esd opengl mmx oggvorbis 3dnow mikmod directfb ipv6 alsa oss arts jack sndfile lirc flac mad ssl"

DEPEND="=x11-libs/gtk+-1.2*
	mikmod? ( >=media-libs/libmikmod-3.1.10 )
	esd? ( >=media-sound/esound-0.2.22 )
	xml? ( >=dev-libs/libxml-1.8.15 )
	opengl? ( virtual/opengl )
	alsa? ( >=media-libs/alsa-lib-0.9.0 )
	ssl? ( dev-libs/openssl )
	oggvorbis? ( >=media-libs/libvorbis-1.0 )"

RDEPEND="${DEPEND}
	directfb? ( dev-libs/DirectFB )
	app-arch/unzip"

#We want these things in DEPEND only
DEPEND="${DEPEND}
	>=sys-devel/automake-1.7
	>=sys-devel/autoconf-2.5
	sys-devel/libtool
	nls? ( dev-util/intltool
	       dev-lang/perl
	       >=sys-devel/gettext-0.14.1 )"

# USE flags pull in xmms plugins
PDEPEND="jack? ( media-plugins/xmms-jack )
	 lirc? ( media-plugins/xmms-lirc )
	 arts? ( media-plugins/xmms-arts )
	 sndfile? ( media-plugins/xmms-sndfile )
	 mad? ( >=media-plugins/xmms-mad-0.7 )
	 flac? ( media-libs/flac )"

src_unpack() {
	unpack ${A}
	cd ${S}

	EPATCH_SUFFIX="patch"
	epatch ${PATCHDIR}

	export WANT_AUTOMAKE=1.7
	export WANT_AUTOCONF=2.5

	for dir in . libxmms; do
		cd ${S}/${dir}
		rm acinclude.m4
		libtoolize --force --copy || die "libtoolize --force --copy failed"
		[ ! -f ltmain.sh ] && ln -s ../ltmain.sh
		aclocal -I ${PATCHDIR}/m4 || die "aclocal failed"
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

	if use amd64; then
		myconf="${myconf} --disable-simd"
	else
	  	if use 3dnow || use mmx; then
			myconf="${myconf} --enable-simd"
		else
			myconf="${myconf} --disable-simd"
		fi
	fi

	use xml || myconf="${myconf} --disable-cdindex"

	if [ -e /dev/sound ]; then
		myconf="${myconf} \
			--with-dev-dsp=/dev/sound/dsp \
			--with-dev-mixer=/dev/sound/mixer"
	fi

	# Please see Bug 58092 for details
	use ppc64 && replace-flags "-O[2-9]" "-O1"

	econf	`use_enable oggvorbis vorbis` \
		`use_enable esd` \
		`use_enable mikmod` \
		`use_with mikmod libmikmod` \
		`use_enable opengl` \
		`use_enable nls` \
		`use_enable ipv6` \
		`use_enable ssl` \
		`use_enable oss oss` \
		${myconf} \
		|| die

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
}
