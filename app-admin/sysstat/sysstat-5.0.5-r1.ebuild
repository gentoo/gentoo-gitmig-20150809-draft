# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/sysstat/sysstat-5.0.5-r1.ebuild,v 1.9 2005/03/31 20:11:02 blubb Exp $

DESCRIPTION="System performance tools for Linux"
HOMEPAGE="http://perso.wanadoo.fr/sebastien.godard/"
SRC_URI="http://perso.wanadoo.fr/sebastien.godard/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc64 sparc ppc hppa amd64"
IUSE="nls"

DEPEND="virtual/libc"
RDEPEND="nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e "s:-O2:${CFLAGS}:" Makefile
	sed -i -e '1d;2i # Crontab sample for app-admin/sysstat' -e '2d;3d;s:PREFIX:/usr:' crontab.sample
}

src_compile() {
	yes '' | make config
	use nls || sed -i 's/\(ENABLE_NLS\ =\ \)y/\1n/g' build/CONFIG
	make PREFIX=/usr || die
}

src_install() {
	dodir /usr/bin
	dodir /usr/share/man/man{1,8}
	dodir /var/log/sa
	keepdir /var/log/sa
	dodir /etc/cron.d
	cp ./crontab.sample ${D}/etc/cron.d/sysstat

	make \
		DESTDIR=${D} \
		PREFIX=/usr \
		MAN_DIR=/usr/share/man \
		DOC_DIR=/usr/share/doc/${PF} \
		install || die
}
