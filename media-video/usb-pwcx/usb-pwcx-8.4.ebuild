# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/usb-pwcx/usb-pwcx-8.4.ebuild,v 1.1 2004/02/11 10:23:51 phosphan Exp $

DESCRIPTION="Optional binary only drivers for phillips (and many other) webcams giving higher resolutions and framerates"
HOMEPAGE="http://www.smcc.demon.nl/webcam/"
SRC_URI="http://www.smcc.demon.nl/webcam/pwcx-${PV}.tar.gz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="~x86 -ppc -sparc  -alpha"
DEPEND=""
S=${WORKDIR}/pwcx-${PV}

src_install() {

	if [ "$(echo $(uname -r) | cut -c-3)" = "2.6" ]; then
		einfo "Kernel 2.6 detected!"
		insinto "/lib/modules/$(uname -r)/video/"
		doins 2.6.0/gcc-3.2/pwcx.ko
		echo "post-install pwc /sbin/modprobe --force pwcx >& /dev/null 2>&1 || :" > usb-pwcx
	else
		einfo "Kernel 2.4 detected!"
		insinto "/lib/modules/usb"
		doins 2.4.23/gcc-3.2/pwcx.o
		echo "post-install pwc /sbin/insmod --force /lib/modules/usb/pwcx.o >& /dev/null 2>&1 || :" > usb-pwcx
	fi

	insinto /etc/modules.d
	doins usb-pwcx

	dodoc README
}

pkg_postinst() {
	if [ "${ROOT}" = "/" ]
	then
		# Update module dependancy
		[ -x /usr/sbin/update-modules ] && /usr/sbin/update-modules
		depmod -a
	fi
}
