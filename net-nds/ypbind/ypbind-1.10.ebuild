# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-nds/ypbind/ypbind-1.10.ebuild,v 1.1 2002/04/27 23:29:39 seemant Exp $

MY_P=${PN}-mt-${PV}
S=${WORKDIR}/ypbind-mt-${PV}
DESCRIPTION="Multithreaded NIS bind service"
SRC_URI="ftp://ftp.de.kernel.org/pub/linux/utils/net/NIS/${MY_P}.tar.gz"
HOMEPAGE="http://www.linux-nis.org/nis/ypbind-mt/index.html"

DEPEND="net-nds/yp-tools
	net-nds/portmap"

RDEPEND="nls? ( sys-devel/gettext )"

src_compile() {

	local myconf
	use nls || myconf="--disable-nls"

	econf ${myconf} || die
	make || die
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog COPYING README THANKS TODO

	insinto /etc ; doins etc/yp.conf

	exeinto /etc/init.d
	newexe ${FILESDIR}/ypbind.rc6 ypbind
}
