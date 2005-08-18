# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/nero/nero-2.0.0.2.ebuild,v 1.2 2005/08/18 17:25:39 mr_bones_ Exp $

inherit eutils rpm

DESCRIPTION="Nero Burning ROM for Linux"
HOMEPAGE="http://www.nero.com/en/NeroLINUX.html" # nerolinux.nero.com coming soon...
NERO_RPM="nerolinux-${PV}-x86.rpm"
SRC_URI="ftp://ftp2.us.nero.com/${NERO_RPM}
	ftp://ftp6.de.nero.com/${NERO_RPM}
	http://httpdl3.nero.com/${NERO_RPM}
	http://httpdl6.nero.com/${NERO_RPM}"
LICENSE="Nero"
SLOT="0"
KEYWORDS="~x86"
IUSE="mp3 oggvorbis shorten"
DEPEND=""
RDEPEND="virtual/libc
	virtual/x11
	>=x11-libs/gtk+-1.2
	>=dev-libs/glib-1.2
	mp3? ( media-sound/mpg123 )
	oggvorbis? ( media-sound/vorbis-tools )
	shorten? ( media-sound/shorten )"
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

	dodir /usr/lib
	insinto /usr/lib
	doins ./usr/lib/*.so

	dobin ./usr/bin/nero

	insinto /usr/share/applications
	doins ${FILESDIR}/nero.desktop
}

# pkg_preinst() {
# 	check_license
# }

pkg_postinst() {
	einfo
	einfo "Please make sure that no hdX=ide-scsi option is passed"
	einfo "to your kernel command line."
	einfo "For setting up your burning device correctly you also"
	einfo "have to set read/write access to the devices that are"
	einfo "mapped to your disc drives, e.g.:"
	einfo "\tchmod a+rw /dev/hd*"
	einfo "\tchmod a+rw /dev/sg*"
	ewarn "This may be a security hole in multiuser environments!"
	einfo
	einfo "NOTE: This is demo software, it will run for a trial"
	einfo "period only until unlocked with a serial number."
	einfo "See ${HOMEPAGE} for details."
	einfo
	einfo "Technical support for NeroLINUX is provided by CDFreaks"
	einfo "Linux forum at http://club.cdfreaks.com/forumdisplay.php?f=104"
	einfo
}
