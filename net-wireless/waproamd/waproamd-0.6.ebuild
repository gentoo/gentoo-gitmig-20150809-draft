# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/waproamd/waproamd-0.6.ebuild,v 1.2 2004/06/25 00:47:06 agriffis Exp $

DESCRIPTION="Wireless roaming daemon for configuring wireless settings"

HOMEPAGE="http://www.stud.uni-hamburg.de/~lennart/projects/waproamd/"
SRC_URI="http://0pointer.de/lennart/projects/waproamd/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-libs/libdaemon-0.5"

src_unpack() {
	unpack ${A}

	cd ${S}
	cp ${FILESDIR}/waproamd.initd ${S}/conf/waproamd.init.in
}

src_compile() {
	econf --disable-lynx --with-initdir=${D}/etc/init.d/ || die
	emake || die
}

src_install() {
	einstall || die
	dodoc README
	insinto /etc/conf.d
	newins ${FILESDIR}/waproamd.confd waproamd
}
