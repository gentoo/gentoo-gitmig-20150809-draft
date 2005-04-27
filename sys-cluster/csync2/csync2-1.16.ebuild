# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/csync2/csync2-1.16.ebuild,v 1.1 2005/04/27 01:24:26 xmerlin Exp $

DESCRIPTION="Cluster synchronization tool."
SRC_URI="http://oss.linbit.com/csync2/${P}.tar.gz"
HOMEPAGE="http://oss.linbit.com/csync2/"

LICENSE="GPL-2"
KEYWORDS="~x86"

IUSE=""

DEPEND="net-libs/librsync"
RDEPEND="net-libs/librsync"
SLOT="0"

src_compile() {
	econf --localstatedir=/var || die

	emake || die
}

src_install() {

	make DESTDIR=${D} localstatedir=${D}/var install || die "install problem"

	insinto /etc/xinetd.d
	newins ${FILESDIR}/${PN}.xinetd ${PN} || die

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
}

