# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/usb-pwcx/usb-pwcx-8.2.2.ebuild,v 1.10 2004/07/14 22:16:17 agriffis Exp $

inherit check-kernel

DESCRIPTION="Optional closed source drivers for phillips webcams to allow for higher resoltions and framerates "
HOMEPAGE="http://www.smcc.demon.nl/webcam/"
SRC_URI="http://www.smcc.demon.nl/webcam/usb-pwcx-8.2.2.tar.gz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="x86 -ppc -sparc -alpha"
IUSE=""

DEPEND=""

pkg_setup() {
	if is_2_6_kernel; then
		eerror "You need a newer version for 2.6 kernels!"
		die "This works only for 2.4 kernels"
	fi
}

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
