# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/xinetd/xinetd-2.3.3-r6.ebuild,v 1.1 2001/09/03 10:30:34 woodchip Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Replacement for inetd."
HOMEPAGE="http://www.xinetd.org"
SRC_URI="http://www.xinetd.org/${P}.tar.gz"

DEPEND="virtual/glibc tcpd? ( >=sys-apps/tcp-wrappers-7.6-r2 )"
RDEPEND="virtual/glibc sys-devel/perl"

src_compile() {
	local myconf
	use tcpd && myconf="$myconf--with-libwrap"
	use ipv6 && myconf="$myconf --with-inet6"

	./configure --with-loadavg --prefix=/usr --mandir=/usr/share/man \
		--host=${CHOST} $myconf || die
	# Parallel make does not work
	make || die
}

src_install() {
	make prefix=${D}/usr MANDIR=${D}/usr/share/man install
	dodoc AUDIT CHANGELOG README COPYRIGHT xinetd/sample.conf
	exeinto /etc/init.d
	newexe ${FILESDIR}/xinetd.rc6 xinetd
	exeinto /usr/sbin
	doexe ${FILESDIR}/xconv.pl
}
