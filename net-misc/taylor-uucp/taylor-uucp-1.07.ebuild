# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/taylor-uucp/taylor-uucp-1.07.ebuild,v 1.6 2003/12/17 02:52:04 zul Exp $

S=${WORKDIR}/uucp-1.07	# This should be a .2 bug the package is messed
DESCRIPTION="Taylor UUCP"
SRC_URI="ftp://ftp.gnu.org/pub/gnu/uucp/uucp-${PV}.tar.gz"
HOMEPAGE="http://www.airs.com/ian/uucp.html"

KEYWORDS="x86 sparc alpha ~amd64"
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/glibc"

src_compile() {
	epatch ${FILESDIR}/gentoo-uucp-${PV}.patch
	sh configure --prefix=/usr \
				 --with-newconfigdir=/etc/uucp
	make || die
}

src_install() {
	dodir /usr/share/man/man1
	dodir /usr/share/man/man8
	dodir /usr/share/info
	dodir /etc/uucp
	dodir /usr/bin
	dodir /usr/sbin
	dodir /var/log/uucp
	dodir /var/lock/uucp
	make \
		prefix=${D}/usr \
		sbindir=${D}/usr/sbin \
		bindir=${D}/usr/bin \
		man1dir=${D}/usr/share/man/man1 \
		man8dir=${D}/usr/share/man/man8 \
		newconfigdir=${D}/etc/uucp \
		infodir=${D}/usr/share/info \
		install install-info || die
	cp sample/* ${D}/etc/uucp
	dodoc COPYING ChangeLog NEWS README TODO
}

pkg_preinst() {
	usermod -s /bin/bash uucp
}
