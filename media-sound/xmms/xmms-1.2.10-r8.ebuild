# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/xmms/xmms-1.2.10-r8.ebuild,v 1.4 2004/10/19 04:16:35 eradicator Exp $

IUSE="xml nls esd opengl mmx oggvorbis 3dnow mikmod directfb ipv6 alsa oss arts jack sndfile lirc flac mad"

inherit flag-o-matic eutils libtool gnuconfig

PATCHVER="2.1"

PATCHDIR="${WORKDIR}/patches"

DESCRIPTION="X MultiMedia System"
HOMEPAGE="http://www.xmms.org/"
SRC_URI="http://www.xmms.org/files/1.2.x/${P}.tar.bz2
	mirror://gentoo/gentoo_ice-xmms-0.2.tar.bz2
	http://dev.gentoo.org/~eradicator/xmms/${P}-gentoo-patches-${PATCHVER}.tar.bz2
	http://dev.gentoo.org/~eradicator/xmms/gnomexmms.xpm"

LICENSE="GPL-2"
SLOT="0"
# Notice to arch maintainers:
# Please test out the plugins listed below in PDEPEND.  They should
# work on most of your archs, but haven't been marked yet.
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64 ~ia64 ~mips ~ppc64"

DEPEND="=x11-libs/gtk+-1.2*
	mikmod? ( >=media-libs/libmikmod-3.1.10 )
	esd? ( >=media-sound/esound-0.2.22 )
	xml? ( >=dev-libs/libxml-1.8.15 )
	opengl? ( virtual/opengl )
	alsa? ( >=media-libs/alsa-lib-0.9.0 )
	oggvorbis? ( >=media-libs/libvorbis-1.0 )"

RDEPEND="${DEPEND}
	directfb? ( dev-libs/DirectFB )
	app-arch/unzip"

#We want these things in DEPEND only
DEPEND="${DEPEND}
	nls? ( dev-util/intltool
	       sys-devel/gettext )"

# USE flags pull in xmms plugins
PDEPEND="!alpha? ( !hppa? ( !ia64? ( !mips? ( !ppc64? ( jack? ( media-plugins/xmms-jack ) ) ) ) ) )
	 !alpha? ( !ia64? ( !ppc64? ( lirc? ( media-plugins/xmms-lirc ) ) ) )
	 !ia64? ( !ppc64? ( arts? ( media-plugins/xmms-arts ) ) )
	 !alpha? ( !hppa? ( !ia64? ( !mips? ( !ppc64? ( sndfile? ( media-plugins/xmms-sndfile ) ) ) ) ) )
	 mad? ( media-plugins/xmms-mad )
	 flac? ( media-libs/flac )"

src_unpack() {
	unpack ${A}
	cd ${S}

	EPATCH_SUFFIX="patch"
	epatch ${PATCHDIR}

	elibtoolize
	gnuconfig_update
}

src_compile() {
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

	econf \
		--with-dev-dsp=/dev/sound/dsp \
		--with-dev-mixer=/dev/sound/mixer \
		`use_enable oggvorbis vorbis` \
		`use_enable esd` \
		`use_enable mikmod` \
		`use_with mikmod libmikmod` \
		`use_enable opengl` \
		`use_enable nls` \
		`use_enable ipv6` \
		`use_enable oss oss` \
		${myconf} \
		|| die

	emake -j1 || die
}

src_install() {
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

	insinto /usr/share/applnk/Multimedia
	doins ${FILESDIR}/xmms.desktop
	insinto /usr/share/applications
	doins ${FILESDIR}/xmms.desktop

	# Add the sexy Gentoo Ice skin
	insinto /usr/share/xmms/Skins/gentoo_ice
	doins ${WORKDIR}/gentoo_ice/*
	docinto gentoo_ice
	dodoc ${WORKDIR}/README
}

pkg_postinst() {
	ewarn "This version of xmms is under development and subject to change."
	ewarn "while it is still in package.mask.  Some features found in earlier"
	ewarn "versions of xmms (cjk support and an id3v2 editor) are not yet"
	ewarn "integrated into this version."
}
