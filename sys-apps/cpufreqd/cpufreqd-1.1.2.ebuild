# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/cpufreqd/cpufreqd-1.1.2.ebuild,v 1.1 2004/07/20 19:40:03 solar Exp $

inherit eutils flag-o-matic

DESCRIPTION="Daemon to adjust CPU speed for power saving"
HOMEPAGE="http://sourceforge.net/projects/cpufreqd/"
SRC_URI="mirror://sourceforge/cpufreqd/${P}.tar.gz"
DEPEND=">=sys-apps/sed-4"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="pie"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i '/^DAEMON=/s:/sbin/:/usr/sbin/:' scripts/gentoo/cpufreqd
}

src_compile() {
	cd ${S}
	use pie && append-flags -fno-pie
	econf || die "econf failed for ${P}"
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
