# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/i2c/i2c-2.6.5-r1.ebuild,v 1.6 2004/01/25 23:15:20 plasmaroo Exp $

DESCRIPTION="I2C Bus support"
HOMEPAGE="http://www2.lm-sensors.nu/~lm78/"
SRC_URI="http://www2.lm-sensors.nu/~lm78/archive/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ppc"

DEPEND="virtual/linux-sources"

src_compile() {
	if [ ! `emake LINUX_INCLUDE_DIR=/usr/include/linux clean all` ] ; then
		eerror "i2c requires the source of a compatible kernel"
		eerror "version installed in /usr/src/linux"
		eerror "and kernel i2c *disabled* or *enabled as a module*"
		die "make failed"
	fi
}

src_install() {
	emake \
		LINUX_INCLUDE_DIR=/usr/include/linux \
		DESTDIR=${D} \
		PREFIX=/usr \
		MANDIR=/usr/share/man \
		install || die
	dodoc CHANGES INSTALL README
}

pkg_postinst() {
	[ -x /usr/sbin/update-modules ] && /usr/sbin/update-modules

	einfo
	einfo "i2c package installed ..."
	einfo
	einfo "IMPORTANT ... if you are installing this package you need to either"
	einfo "IMPORTANT ... *disable* kernel i2c support or *enable it as a module*"
	einfo
}
