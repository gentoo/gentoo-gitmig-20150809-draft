# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mozilla-thunderbird-bin/mozilla-thunderbird-bin-0.5.ebuild,v 1.2 2004/02/14 06:19:38 brad Exp $

inherit nsplugins eutils

IUSE="gnome"

MY_PN=${PN/-bin/}
S=${WORKDIR}/thunderbird

DESCRIPTION="The Mozilla Thunderbird Mail & News Reader"
SRC_URI="http://ftp.mozilla.org/pub/mozilla.org/thunderbird/releases/${PV}/thunderbird-${PV}-i686-pc-linux-gtk2-gnu.tar.bz2"

HOMEPAGE="http://www.mozilla.org/projects/thunderbird"
RESTRICT="nostrip"

KEYWORDS="x86 -ppc -sparc -alpha"
SLOT="0"
LICENSE="MPL-1.1 | NPL-1.1"
IUSE="gtk2 crypt"

DEPEND="virtual/glibc"
RDEPEND="virtual/x11
	>=dev-libs/libIDL-0.8.0
	>=gnome-base/ORBit-0.5.10-r1
	>=x11-libs/gtk+-2.1.1
	virtual/xft
	>=media-libs/jpeg-6b
	>=media-libs/libmng-1.0.0
	>=media-libs/libpng-1.2.1
	dev-libs/expat
	app-arch/zip
	app-arch/unzip
	!net-mail/mozilla-thunderbird"

src_install() {
	dodir /opt

	mv ${S} ${D}/opt/MozillaThunderbird

	# Fixing permissions
	chown -R root:root ${D}/opt/MozillaThunderbird

	# Truetype fonts
	cd ${D}/opt/MozillaThunderbird/defaults/pref
	einfo "Enabling truetype fonts. Filesdir is ${FILESDIR}"
	epatch ${FILESDIR}/thunderbird-0.3-antialiasing-patch

	# Misc stuff
	dobin ${FILESDIR}/thunderbird

	# Install icon and .desktop for menu entry
	if [ "`use gnome`" ]
	then
		insinto /usr/share/pixmaps
		doins ${FILESDIR}/${PV}/icon/thunderbird-icon.png

		insinto /usr/share/gnome/apps/Internet
		doins ${FILESDIR}/${PV}/icon/mozillathunderbird.desktop
	fi
}

pkg_postinst() {
	einfo "To enable Enigmail, you must install the Enigmail and Enigmime"
	einfo "extensions as root.  Go to Tools / Options / Extensions and click"
	einfo "on Install Extension to install Enigmail in your Thunderbird build."
	einfo "Restart Thunderbird after having installed both extensions."
	einfo ""
	einfo "The extensions are located at http://enigmail.mozdev.org/."
	einfo ""
	einfo "Please note that the binary name has changed from MozillaThunderbird"
	einfo "to simply 'thunderbird'."
	einfo ""
}
