# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/cpufreqd/cpufreqd-1.1.ebuild,v 1.1 2004/01/27 03:32:40 vapier Exp $

inherit eutils

S=${WORKDIR}/${P/_/-}.orig
DESCRIPTION="Daemon to adjust CPU speed for power saving"
HOMEPAGE="http://sourceforge.net/projects/cpufreqd/"
SRC_URI="mirror://sourceforge/${PN}/${P/-/_}.0.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* x86 ppc"

src_unpack() {
	unpack ${A}
	cd ${S}
	#correct the init-script
	sed -i -e s:/bin/cpufreqd:/usr/sbin/cpufreqd: ${S}/scripts/gentoo/cpufreqd
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README Authors TODO

	exeinto /etc/init.d
	newexe ${S}/scripts/gentoo/cpufreqd cpufreqd
}

pkg_postinst() {
	echo
	einfo "A default config file has been copied to /etc/cpufreqd.conf"
	echo
	einfo "CPUFreqd does not support using percentage frequencies on"
	einfo "2.6 kernels where sysfs is used instead - please manually"
	einfo "edit the config file to use an absolute value instead, if"
	einfo "you are using a 2.6 series kernel."
	echo
}
