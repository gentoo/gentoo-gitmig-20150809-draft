# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/nero/nero-2.1.0.3.ebuild,v 1.5 2007/06/30 11:47:41 drac Exp $

inherit eutils rpm multilib

DESCRIPTION="Nero Burning ROM for Linux"
HOMEPAGE="http://nerolinux.nero.com/"
NERO_RPM="nerolinux-${PV}-x86.rpm"
SRC_URI="http://httpdl3.de.nero.com/${NERO_RPM}
	http://httpdl4.de.nero.com/${NERO_RPM}
	http://httpdl5.de.nero.com/${NERO_RPM}
	http://httpdl6.de.nero.com/${NERO_RPM}
	ftp://ftp3.de.nero.com/${NERO_RPM}
	ftp://ftp4.de.nero.com/${NERO_RPM}
	ftp://ftp5.de.nero.com/${NERO_RPM}
	ftp://ftp6.de.nero.com/${NERO_RPM}"
LICENSE="Nero"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="mp3 ogg shorten sox vorbis"
DEPEND=""
RDEPEND="sys-libs/glibc
	|| ( x11-libs/libX11 virtual/x11 )
	=x11-libs/gtk+-1.2*
	amd64? ( >=app-emulation/emul-linux-x86-gtklibs-2.0 )
	mp3? ( media-sound/mpg123 media-sound/lame media-sound/mp3info )
	ogg? ( media-sound/oggtst )
	shorten? ( media-sound/shorten media-sound/shntool )
	sox? ( media-sound/sox )
	vorbis? ( media-sound/vorbis-tools )"

RESTRICT="nostrip nomirror"

src_unpack() {
	rpm_src_unpack
}

src_compile() { :; }

src_install() {
	cd ${WORKDIR}

	dodir /usr/share/nero
	insinto /usr/share/nero
	doins ./usr/share/nero/{*.so,DosBootImage.ima,Nero.txt,CDROM.CFG}

	dodir /usr/share/nero/desktop
	insinto /usr/share/nero/desktop
	doins ./usr/share/nero/desktop/NeroLINUX.template

	dodir /usr/share/nero/docs
	insinto /usr/share/nero/docs
	doins ./usr/share/nero/docs/{Manual.pdf,EULA,NEWS}

	dodir /usr/share/nero/pixmaps
	insinto /usr/share/nero/pixmaps
	doins ./usr/share/nero/pixmaps/nero.png

	dodir /usr/share/nero/sounds
	insinto /usr/share/nero/sounds
	doins ./usr/share/nero/sounds/*.wav

	libdir=$(get_libdir)
	dodir /usr/${libdir}
	insinto /usr/${libdir}
	doins ./usr/lib/*.so

	dobin ./usr/bin/nero

	insinto /usr/share/applications
	doins ${FILESDIR}/nero.desktop
}

pkg_setup() {
	# This is a binary x86 package => ABI=x86
	has_multilib_profile && ABI="x86"
}

# TODO
# pkg_preinst() {
# 	check_license
# }

pkg_postinst() {
	elog
	elog "Please make sure that no hdX=ide-scsi option is passed"
	elog "to your kernel command line."
	elog
	elog "For setting up your burning device correctly you also"
	elog "have to give your regular user(s) read/write access to"
	elog "the disc writer devices, for example by adding the user(s)"
	elog "to the system group 'cdrom', e.g. like this:"
	elog
	elog "\tgpasswd -a <username> cdrom"
	elog
	elog "NOTE: This is demo software, it will run for a trial"
	elog "period only until unlocked with a serial number."
	elog "See ${HOMEPAGE} for details."
	elog
	elog "Technical support for NeroLINUX is provided by CDFreaks"
	elog "Linux forum at http://club.cdfreaks.com/forumdisplay.php?f=104"
	elog
}
