# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/ypserv/ypserv-2.5.ebuild,v 1.3 2003/02/13 15:14:57 vapier Exp $

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="NIS SERVER"
SRC_URI="ftp://ftp.de.kernel.org/pub/linux/utils/net/NIS/${P}.tar.gz
	 ftp://ftp.uk.kernel.org/pub/linux/utils/net/NIS/${P}.tar.gz
	 ftp://ftp.kernel.org/pub/linux/utils/net/NIS/${P}.tar.gz"
HOMEPAGE="http://www.linux-nis.org/nis/"

SLOT="1"
LICENSE="GPL-2"
KEYWORDS="x86 sparc "

DEPEND=">=sys-libs/gdbm-1.8.0"

src_compile() {
	econf --enable-yppasswd || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README THANKS TODO

	insinto /etc ; doins etc/ypserv.conf etc/locale etc/netgroup etc/netmasks etc/timezone

	insinto /var/yp ; doins etc/securenets

	exeinto /etc/init.d
	newexe ${FILESDIR}/ypserv.rc6 ypserv
}

pkg_postinst() {
	einfo "ypserv does not longer have support for tcp_wrappers. You need to"
	einfo "use /var/yp/securenets to allow/deny queries from other hosts."
}
