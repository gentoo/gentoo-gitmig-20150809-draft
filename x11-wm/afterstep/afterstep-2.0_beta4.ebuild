# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/afterstep/afterstep-2.0_beta4.ebuild,v 1.1 2004/03/19 01:07:58 raker Exp $

IUSE="png jpeg gif tiff truetype xinerama debug mmx"

DESCRIPTION="Window manager based on the look and feel of the NeXTStep"
HOMEPAGE="http://www.afterstep.org"
SRC_URI="ftp://ftp.afterstep.org/devel/AfterStep-2.00.beta4b.tar.bz2"

LICENSE="AFTERSTEP"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/glibc
	virtual/x11
	png? ( >=media-libs/libpng-1.2.5 )
	jpeg? ( >=media-libs/jpeg-6b )
	gif?  ( >=media-libs/giflib-4.1.0 )
	tiff? ( >=media-libs/tiff-3.5.7 )
	debug? ( >=dev-util/efence-2.2.2 )"
RDEPEND="${DEPEND}
	>=media-sound/sox-12.17.3"

S="${WORKDIR}/AfterStep-2.00.beta4b"

src_unpack () {
	unpack ${A}
	cd ${S}
	# see bug #31541
	# updated to -r1 for beta4 - raker@gentoo.org
	epatch ${FILESDIR}/as2-gnome-r1.diff
}

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

	use debug && myconf="${myconf} --with-libefence --enable-gdb --enable-warn --enable-gprof --enable-audit --enable-trace --enable-trace-x"

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
		--with-xpm \
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

	# Create a symlink from MonitorWharf to Wharf
	rm ${D}/usr/bin/MonitorWharf
	dosym /usr/bin/Wharf /usr/bin/MonitorWharf

	# Handle the documentation
	dodoc COPYRIGHT ChangeLog INSTALL NEW* README* TEAM UPGRADE
	cp -a ${S}/TODO ${D}/usr/share/doc/${PF}/
	dodir /usr/share/doc/${PF}/html
	cp -a ${S}/doc/* ${D}/usr/share/doc/${PF}/html
	rm ${D}/usr/share/doc/${PF}/html/{Makefile*,afterstepdoc.in}

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

