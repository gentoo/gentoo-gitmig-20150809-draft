# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/cpufreqd/cpufreqd-1.1_rc1.ebuild,v 1.1 2003/11/19 17:46:13 tantive Exp $

S=${WORKDIR}/${P/_/-}

DESCRIPTION="Daemon to adjust cpu speed for powersaving"
SRC_URI="mirror://sourceforge/${PN}/${P/_/-}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/cpufreqd/"
KEYWORDS="~x86 ~ppc -*"
LICENSE="GPL-2"
SLOT="0"

inherit eutils

src_unpack() {
	unpack ${A}
	cd ${S}
}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README Authors TODO

	exeinto /etc/init.d
	newexe ${S}/scripts/gentoo/cpufreqd
}
pkg_postinst() {
	echo
	einfo "A default config file has been copied to /etc/cpufreqd.conf"
	echo
}
