# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/mozilla-thunderbird-bin/mozilla-thunderbird-bin-0.6.ebuild,v 1.6 2004/07/14 16:21:25 agriffis Exp $

inherit nsplugins eutils

MY_PN=${PN/-bin/}
S=${WORKDIR}/thunderbird

DESCRIPTION="The Mozilla Thunderbird Mail & News Reader"
SRC_URI="http://ftp.mozilla.org/pub/mozilla.org/thunderbird/releases/${PV}/thunderbird-${PV}-i686-linux-gtk2+xft.tar.gz"

HOMEPAGE="http://www.mozilla.org/projects/thunderbird"
RESTRICT="nostrip"

KEYWORDS="-* ~x86"
SLOT="0"
LICENSE="MPL-1.1 | NPL-1.1"
IUSE="gnome"

DEPEND="virtual/libc"
RDEPEND="virtual/x11
	>=dev-libs/libIDL-0.8.0
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

	# Misc stuff
	dobin ${FILESDIR}/thunderbird

	# Install icon and .desktop for menu entry
	if use gnome
	then
		insinto /usr/share/pixmaps
		doins ${FILESDIR}/icon/thunderbird-icon.png

		insinto /usr/share/gnome/apps/Internet
		doins ${FILESDIR}/icon/mozillathunderbird.desktop
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
