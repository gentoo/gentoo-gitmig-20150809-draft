# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ifplugd/ifplugd-0.13-r1.ebuild,v 1.7 2005/01/31 10:59:20 ka0ttic Exp $

DESCRIPTION="Brings up/down ethernet ports automatically with cable detection"
HOMEPAGE="http://0pointer.de/lennart/projects/ifplugd/"
SRC_URI="http://0pointer.de/lennart/projects/ifplugd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND=">=sys-apps/sed-4"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e "s|\(^CFLAGS=\).*$|\1${CFLAGS}|" Makefile \
		-e 's:/etc/ifplugd/ifplugd.action:/usr/sbin/ifplugd.action:' ifplugd.c \
		|| die "sed failed"
}

src_install() {
	dosbin ifplugd ${FILESDIR}/ifplugd.action ifstatus
	doman ifplugd.8 ifstatus.8

	insinto /etc/conf.d ; newins ifplugd.conf ifplugd
	exeinto /etc/init.d ; doexe ${FILESDIR}/ifplugd

	dodoc README SUPPORTED_DRIVERS FAQ NEWS
}
