# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/usb-pwcx/usb-pwcx-8.2.2.ebuild,v 1.5 2003/09/07 00:08:13 msterret Exp $

DESCRIPTION="Optional closed source drivers for phillips webcams to allow for higher resoltions and framerates "
HOMEPAGE="http://www.smcc.demon.nl/webcam/"
SRC_URI="http://www.smcc.demon.nl/webcam/usb-pwcx-8.2.2.tar.gz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="~x86 -ppc -sparc  -alpha"

DEPEND=""

src_install() {
	insinto "/lib/modules/usb"
	doins pwcx-i386.o

	insinto /etc/modules.d
	doins "${FILESDIR}"/usb-pwcx

	dodoc install.html readme.html webcam.css
}

pkg_postinst() {
	if [ "${ROOT}" = "/" ]
	then
		# Update module dependancy
		[ -x /usr/sbin/update-modules ] && /usr/sbin/update-modules
	fi
}
