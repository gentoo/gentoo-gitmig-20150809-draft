# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/afterstep/afterstep-2.00.04.ebuild,v 1.2 2005/03/30 17:35:06 ka0ttic Exp $

inherit flag-o-matic

DESCRIPTION="AfterStep is a feature rich NeXTish window manager"
HOMEPAGE="http://www.afterstep.org"
SRC_URI="ftp://ftp.afterstep.org/stable/AfterStep-${PV}.tar.bz2"

LICENSE="AFTERSTEP"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"
IUSE="debug gif jpeg mmx nls png tiff truetype xinerama"

DEPEND="virtual/libc
	virtual/x11
	png? ( >=media-libs/libpng-1.2.5 )
	jpeg? ( >=media-libs/jpeg-6b )
	gif?  ( >=media-libs/giflib-4.1.0 )
	tiff? ( >=media-libs/tiff-3.5.7 )"

S="${WORKDIR}/AfterStep-${PV}"

src_compile() {
	local myconf

	use nls && myconf="--enable-i18n" \
		|| myconf="--enable-i18n=no"

	use png && myconf="${myconf} --with-png" \
		|| myconf="${myconf} --with-png=no"

	use jpeg && myconf="${myconf} --with-jpeg" \
		|| myconf="${myconf} --with-jpeg=no"

	use gif && myconf="${myconf} --with-gif" \
		|| myconf="${myconf} --with-gif=no"

	use tiff && myconf="${myconf} --with-tiff" \
		|| myconf="${myconf} --with-tiff=no"

	use truetype && myconf="${myconf} --with-ttf --enable-reuse-font=no" \
		|| myconf="${myconf} --with-ttf=no"

	use xinerama && myconf="${myconf} --enable-xinerama" \
		|| myconf="${myconf} --enable-xinerama=no"

	use mmx && myconf="${myconf} --enable-mmx-optimization" \
		|| myconf="${myconf} --enable-mmx-optimization=no"

	use debug && myconf="${myconf} --enable-gdb --enable-warn --enable-gprof --enable-audit --enable-trace --enable-trace-x"

	use !ppc && use debug && myconf="${myconf} --with-libefence"


	#implied intent of debug means you need the frame pointers.
	use debug && filter-flags -fomit-frame-pointer


	# Explanation of configure options
	# ================================
	# --with-helpcommand="xterm -e man" -  Avoid installing xiterm
	# --with-xpm - Contained in xfree
	# --with-ungif=no - Use giflib instead of libungif
	# --disable-availability - So we can use complete paths for menuitems
	# --enable-ascp - The AfterStep ControlPanel is abandoned
	#

	econf \
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

	make DESTDIR=${D} install || die "make install failed"

	# This fixes a bug with shared libraries
	rm ${D}/usr/lib/{libAfterImage.a,libAfterBase.a}
	cp -a ${S}/libAfterImage/libAfterImage.so* ${D}/usr/lib
	cp -a ${S}/libAfterBase/libAfterBase.so* ${D}/usr/lib
	cp -a ${S}/libAfterConf/libAfterConf.so* ${D}/usr/lib
	cp -a ${S}/libAfterStep/libAfterStep.so* ${D}/usr/lib

	# Create a symlink from MonitorWharf to Wharf
	rm ${D}/usr/bin/MonitorWharf
	dosym /usr/bin/Wharf /usr/bin/MonitorWharf

	# Handle the documentation
	dodoc COPYRIGHT ChangeLog INSTALL NEW* README* TEAM UPGRADE
	cp -a ${S}/TODO ${D}/usr/share/doc/${PF}/
	dodir /usr/share/doc/${PF}/html
	cp -a ${S}/doc/* ${D}/usr/share/doc/${PF}/html
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

