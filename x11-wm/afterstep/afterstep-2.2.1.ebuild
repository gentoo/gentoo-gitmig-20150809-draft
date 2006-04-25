# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/afterstep/afterstep-2.2.1.ebuild,v 1.1 2006/04/25 13:58:12 spock Exp $

inherit flag-o-matic

DESCRIPTION="AfterStep is a feature rich NeXTish window manager"
HOMEPAGE="http://www.afterstep.org"
SRC_URI="ftp://ftp.afterstep.org/stable/AfterStep-${PV}.tar.bz2"

LICENSE="AFTERSTEP"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug gif jpeg mmx nls png tiff xinerama"

RDEPEND="virtual/libc
	media-libs/freetype
	debug? ( !hppa? ( !ppc? ( dev-util/efence ) ) )
	png? ( >=media-libs/libpng-1.2.5 )
	jpeg? ( >=media-libs/jpeg-6b )
	gif?  ( >=media-libs/giflib-4.1.0 )
	tiff? ( >=media-libs/tiff-3.5.7 )
	|| ( ( x11-libs/libICE
			x11-libs/libXext
			x11-libs/libSM
			x11-libs/libXmu
			x11-libs/libXt
			x11-libs/libX11
			x11-libs/libXpm
			x11-libs/libXrender
			xinerama? ( x11-libs/libXinerama )
		)
		virtual/x11
	)"

DEPEND="${RDEPEND}
	|| ( ( x11-proto/xextproto
			x11-proto/xproto
			xinerama? ( x11-proto/xineramaproto )
		)
		virtual/x11
	)"

S="${WORKDIR}/AfterStep-${PV}"

src_compile() {
	local myconf

	use debug && myconf="--enable-gdb --enable-warn --enable-gprof
		--enable-audit --enable-trace --enable-trace-x"

	if ! use ppc && use debug ; then
		myconf="${myconf} --with-libefence"
	fi

	#implied intent of debug means you need the frame pointers.
	use debug && filter-flags -fomit-frame-pointer

	# Explanation of configure options
	# ================================
	# --with-helpcommand="xterm -e man" -  Avoid installing xiterm
	# --with-xpm - Contained in xfree
	# --with-ungif=no - Use giflib instead of libungif
	# --disable-availability - So we can use complete paths for menuitems
	# --enable-ascp - The AfterStep ControlPanel is abandoned

	econf \
		$(use_enable nls i18n) \
		$(use_enable mmx mmx-optimization) \
		$(use_enable xinerama) \
		$(use_with png) \
		$(use_with jpeg) \
		$(use_with gif) \
		$(use_with tiff) \
		--with-helpcommand="xterm -e man" \
		--with-ungif=no \
		--disable-availability \
		--disable-staticlibs \
		--enable-ascp=no \
		${myconf} || die "configure failed"

	emake || die "emake failed"
}

src_install() {
	# see bug #31541
	dodir /usr/share/gnome/wm-properties

	# afterstep tries to detect the current resolution
	# for documentation generation, causing access violations
	# for the video device.  bug #87356
	unset DISPLAY

	make DESTDIR=${D} install || die "make install failed"

	# This fixes a bug with shared libraries
	rm ${D}/usr/lib/{libAfterImage.a,libAfterBase.a}
	cp -pPR ${S}/libAfterImage/libAfterImage.so* ${D}/usr/lib
	cp -pPR ${S}/libAfterBase/libAfterBase.so* ${D}/usr/lib
	cp -pPR ${S}/libAfterConf/libAfterConf.so* ${D}/usr/lib
	cp -pPR ${S}/libAfterStep/libAfterStep.so* ${D}/usr/lib

	# Create a symlink from MonitorWharf to Wharf
	rm ${D}/usr/bin/MonitorWharf
	dosym /usr/bin/Wharf /usr/bin/MonitorWharf

	# Handle the documentation
	dodoc COPYRIGHT ChangeLog INSTALL NEW* README* TEAM UPGRADE
	cp -pPR ${S}/TODO ${D}/usr/share/doc/${PF}/
	dodir /usr/share/doc/${PF}/html
	cp -pPR ${S}/doc/* ${D}/usr/share/doc/${PF}/html
	rm ${D}/usr/share/doc/${PF}/html/{Makefile*,afterstepdoc.in}

	dodir /usr/share/xsessions
	insinto /usr/share/xsessions
	newins ${S}/AfterStep.desktop.final AfterStep.desktop

	# For desktop managers like GDM or KDE
	exeinto /etc/X11/Sessions
	doexe ${FILESDIR}/afterstep
}

pkg_postinst() {
	echo
	einfo "To use AfterStep issue the following commands:"
	einfo "mv ~/.xinitrc ~/xinitrc.old"
	einfo "echo afterstep > ~/.xinitrc"
	echo
	einfo "If you like AfterStep please vote for it at"
	einfo "http://www.PLiG.org/xwinman/vote.html !"
	echo
}

