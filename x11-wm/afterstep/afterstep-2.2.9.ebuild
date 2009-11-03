# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/afterstep/afterstep-2.2.9.ebuild,v 1.2 2009/11/03 15:21:55 voyageur Exp $

EAPI=2
inherit autotools flag-o-matic eutils

DESCRIPTION="AfterStep is a feature rich NeXTish window manager"
HOMEPAGE="http://www.afterstep.org"
SRC_URI="ftp://ftp.afterstep.org/stable/AfterStep-${PV}.tar.bz2"

LICENSE="AFTERSTEP"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="alsa debug dbus gif gtk jpeg mmx nls png svg tiff xinerama"

RDEPEND="media-libs/freetype
	alsa? ( media-libs/alsa-lib )
	dbus? ( sys-apps/dbus )
	jpeg? ( >=media-libs/jpeg-6b )
	gif?  ( >=media-libs/giflib-4.1.0 )
	gtk? ( x11-libs/gtk+:2 )
	png? ( >=media-libs/libpng-1.2.5 )
	svg? ( gnome-base/librsvg:2 )
	tiff? ( >=media-libs/tiff-3.5.7 )
	x11-libs/libICE
	x11-libs/libXext
	x11-libs/libSM
	x11-libs/libXmu
	x11-libs/libXt
	x11-libs/libX11
	x11-libs/libXpm
	x11-libs/libXrender
	xinerama? ( x11-libs/libXinerama )"

DEPEND="${RDEPEND}
	x11-proto/xextproto
	x11-proto/xproto
	xinerama? ( x11-proto/xineramaproto )"

S=${WORKDIR}/AfterStep-${PV}

src_prepare() {
	epatch "${FILESDIR}"/no-alternatives-${PV}.patch

	# Do not strip binaries, bug #252119
	sed -e "/STRIP_BINARIES/s/-s//" \
		-i autoconf/configure.in || die "strip sed failed"
	# Do not use bundled libungif, bug #253259
	sed -e '/--with-builtin-gif/s/$with_gif/no/' \
		-i autoconf/configure.in || die "bundled gif sed failed"
	
	cd "${S}"/autoconf || die "cd autoconf failed"
	eautoreconf
	cp "${S}"/autoconf/autoconf/config.h.in "${S}"/autoconf || die "cp failed"
	cp "${S}"/autoconf/configure "${S}" || die "cp failed"
}

src_configure() {
	local myconf

	use debug && myconf="--enable-gdb --enable-warn --enable-gprof
		--enable-audit --enable-trace --enable-trace-x"

	#implied intent of debug means you need the frame pointers.
	use debug && filter-flags -fomit-frame-pointer

	# Explanation of configure options
	# ================================
	# --with-helpcommand="xterm -e man" -  Avoid installing xiterm
	# --with-xpm - Contained in xfree
	# --disable-availability - So we can use complete paths for menuitems
	# --enable-ascp - The AfterStep ControlPanel is abandoned
	# LDCONFIG - bug #265841

	LDCONFIG=/bin/true econf \
		$(use_enable alsa) \
		$(use_enable mmx mmx-optimization) \
		$(use_enable nls i18n) \
		$(use_enable xinerama) \
		$(use_with dbus dbus1) \
		$(use_with gif) \
		$(use_with gtk) \
		$(use_with jpeg) \
		$(use_with png) \
		$(use_with tiff) \
		$(use_with svg) \
		--with-helpcommand="xterm -e man" \
		--disable-availability \
		--disable-staticlibs \
		--enable-ascp=no \
		${myconf} || die "configure failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	# Create a symlink from MonitorWharf to Wharf
	rm "${D}"/usr/bin/MonitorWharf
	dosym /usr/bin/Wharf /usr/bin/MonitorWharf

	# Handle the documentation
	dodoc ChangeLog INSTALL NEW* README* TEAM UPGRADE
	cp -pPR "${S}"/TODO "${D}"/usr/share/doc/${PF}/
	dodir /usr/share/doc/${PF}/html
	cp -pPR "${S}"/doc/* "${D}"/usr/share/doc/${PF}/html
	rm "${D}"/usr/share/doc/${PF}/html/{Makefile*,afterstepdoc.in}

	insinto /usr/share/xsessions
	newins "${S}"/AfterStep.desktop.final AfterStep.desktop

	# For desktop managers like GDM or KDE
	exeinto /etc/X11/Sessions
	doexe "${FILESDIR}"/afterstep
}
