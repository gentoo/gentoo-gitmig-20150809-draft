# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/sysstat/sysstat-6.0.0.ebuild,v 1.3 2005/08/05 12:57:44 ferdy Exp $

inherit eutils

DESCRIPTION="System performance tools for Linux"
HOMEPAGE="http://perso.wanadoo.fr/sebastien.godard/"
SRC_URI="http://perso.wanadoo.fr/sebastien.godard/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE="nls"

DEPEND="nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e "s:-O2:${CFLAGS}:" Makefile
	sed -i -e '1d;2i # Crontab sample for app-admin/sysstat' -e '2d;3d;s:PREFIX:/usr:' crontab.sample
	epatch ${FILESDIR}/${P}-gcc4.diff
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
		SA_LIB_DIR=/usr/lib/sa \
		install || die
}
