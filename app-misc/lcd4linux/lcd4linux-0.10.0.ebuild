# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/lcd4linux/lcd4linux-0.10.0.ebuild,v 1.6 2006/12/19 17:54:25 jokey Exp $

inherit eutils

DESCRIPTION="Shows system and ISDN information on an external display or in a X11 window"
HOMEPAGE="http://ssl.bulix.org/projects/lcd4linux/"
SRC_URI="mirror://sourceforge/lcd4linux/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
# contains x86 asm, upstream is working on a portable version
KEYWORDS="~x86"
IUSE="kde png serdisp X usb mysql python"

DEPEND="png? ( media-libs/libpng
	media-libs/gd )
	X? ( x11-libs/libX11 )
	usb? ( dev-libs/libusb )
	serdisp? ( dev-libs/serdisplib )
	mysql? ( virtual/mysql )"
#		python? ( dev-lang/python )
# mpd is needed soon
# python is broken

pkg_preinst() {
	einfo "If you wish to compile only specific drivers or plugins, please use"
	einfo "the LCD4LINUX_PLUGINS and LCD4LINUX_DRIVERS environment variables."
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-kernel2.6.19.patch"
	epatch "${FILESDIR}/${P}-gcc4-compat.patch"
}

src_compile() {
	local myconf myp myd

	# need to grab upstream's *.m4 and fix python building
	# they didn't have python properly set up originally.
	#myconf="${myconf} $(use_with python)"
	myconf="${myconf} --without-python"

	# plugins
	if [ -n "$LCD4LINUX_PLUGINS" ]; then
		myp="$LCD4LINUX_PLUGINS"
		einfo "Active plugins (overridden): ${myp}"
	else
		myp="all"
		use mysql || myp="${myp},!mysql"
		#use python || myp="${myp},!python"
		myp="${myp},!python"
		einfo "Active plugins: ${myp}"
	fi

	# drivers
	if [ -n "$LCD4LINUX_DRIVERS" ]; then
		myd="$LCD4LINUX_DRIVERS"
		einfo "Active drivers (overridden): ${myd}"
	else
		myd="all"
		use serdisp || myd="${myd},!serdisplib"
		use usb     || myd="${myd},!USBLCD"
		use png     || myd="${myd},!PNG"
		use X       || myd="${myd},!X11"
		einfo "Active drivers: ${myd}"
	fi

	# avoid package brokenness
	use X && myconf="${myconf} --x-libraries=/usr/lib --x-include=/usr/include"
	use X || myconf="${myconf} --without-x"

	econf \
		--sysconfdir=/etc/lcd4linux \
		--with-drivers="${myd}" \
		--with-plugins="${myp}" \
		${myconf} \
		|| die "econf failed"

	sed -i.orig -e 's,-L -lX11, -lX11 ,g' Makefile || die "sed fixup failed"

	emake || die
}

src_install() {
	# upstream's makefile acts weird, and tries to recompile stuff
	into /usr
	dobin lcd4linux

	dodoc README* NEWS TODO CREDITS FAQ AUTHORS ChangeLog

	#newconfd ${FILESDIR}/${PN}.confd ${PN}
	#newinitd ${FILESDIR}/${PN}.initd ${PN}

	dodir /etc/lcd4linux

	if use X || use kde; then
	  insinto /usr/share/pixmaps
	  doins lcd4linux.xpm
	fi
	use X && touch ${D}/etc/lcd4linux/lcd4X11.conf

	if use kde ; then
		insinto /usr/share/applnk/apps/System
		doins lcd4linux.kdelnk
		insinto /etc/lcd4linux
		insopts -o root -g root -m 0600
		doins lcd4kde.conf
	fi

	insinto /etc/lcd4linux
	insopts -o root -g root -m 0600
	newins lcd4linux.conf.sample lcd4linux.conf
}
