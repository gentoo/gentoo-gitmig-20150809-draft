# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/sparc-utils/sparc-utils-1.9.ebuild,v 1.22 2004/07/15 02:35:41 agriffis Exp $

inherit eutils

S=${WORKDIR}/${P}.orig
DESCRIPTION="Various sparc utilites from Debian GNU/Linux"
HOMEPAGE="http://www.debian.org/"
SRC_URI=" http://http.us.debian.org/debian/pool/main/s/${PN}/${PN}_${PV}.orig.tar.gz
	mirror://gentoo/${PN}_${PV}-2.diff.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="-* sparc"
IUSE=""

DEPEND="virtual/os-headers"
RDEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	epatch ${WORKDIR}/${PN}_${PV}-2.diff
}

src_compile() {
	CFLAGS="-O3"
	emake -C elftoaout-2.3 CFLAGS="$CFLAGS" || die
	emake -C src piggyback piggyback64 CFLAGS="$CFLAGS" || die
	emake -C prtconf-1.3 all || die
	# TODO: Fix compile issue
	# Not compiling at this time, commented out
	#emake -C sparc32-1.1
	emake -C audioctl-1.3 || die
}

src_install() {
	dodir /usr/bin /usr/sbin /etc/init.d /etc/default
	install -s elftoaout-2.3/elftoaout ${D}/usr/bin
	install -s src/piggyback src/piggyback64 ${D}/usr/bin
	#install -s sparc32-1.1/sparc32 ${D}/usr/bin

	install -s prtconf-1.3/prtconf ${D}/usr/sbin/prtconf
	install -s prtconf-1.3/eeprom ${D}/usr/sbin/eeprom
	#ln -sf sparc32 ${D}/usr/bin/
	install -s audioctl-1.3/audioctl ${D}/usr/bin
	# install /etc/init.d script & /etc/default scripts
	install -d -m 755 ${D}/etc ${D}/etc/init.d ${D}/etc/default
	#install -m 755 debian/audioctl ${D}/etc/init.d
	install -m 755 debian/audioctl.def ${D}/etc/default/audioctl
}

pkg_postinst() {
	# Todo: Somehow set this automatically
	ewarn "Make sure /dev/openprom exists. If you're not using devfs and"
	ewarn "/dev/openprom does not exist, run"
	ewarn ""
	ewarn "\tcd /dev ; mknod openprom c 10 139"
}
