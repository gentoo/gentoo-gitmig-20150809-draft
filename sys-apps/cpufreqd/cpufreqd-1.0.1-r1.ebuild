# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/cpufreqd/cpufreqd-1.0.1-r1.ebuild,v 1.2 2004/01/05 08:55:29 plasmaroo Exp $

DESCRIPTION="Daemon to adjust CPU speed for kernel using the cpufreq patch."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/cpufreqd/"
KEYWORDS="x86"
LICENSE="GPL-1"
SLOT="0"

src_compile() {
	 epatch ${FILESDIR}/sysfs.diff || die
	./configure \
		--host=${CHOST} \
		--prefix=/ \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--sysconfdir=/etc
	make || die "compile of cpufreqd failed"
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README Authors TODO

	exeinto /etc/init.d
	newexe ${S}/scripts/gentoo/cpufreqd cpufreqd
}
pkg_postinst() {

	echo
	einfo "A default config file is copied to /etc/cpufreqd.conf"
	echo
	einfo "CPUFreqd does not support using percentage frequencies on"
	einfo "2.6 kernels where sysfs is used instead - please manually"
	einfo "edit the config file to use an absolute value instead, if"
	einfo "you are using a 2.6 series kernel."
	echo

}
