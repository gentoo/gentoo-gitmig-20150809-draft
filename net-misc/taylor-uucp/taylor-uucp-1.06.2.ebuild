# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/taylor-uucp/taylor-uucp-1.06.2.ebuild,v 1.8 2002/12/27 23:51:23 rphillips Exp $

S=${WORKDIR}/uucp-1.06.1	# This should be a .2 bug the package is messed
DESCRIPTION="Taylor UUCP"
SRC_URI="ftp://ftp.gnu.org/pub/gnu/uucp/uucp-${PV}.tar.gz"
HOMEPAGE="http://www.airs.com/ian/uucp.html"

KEYWORDS="x86 sparc "
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/glibc"

src_compile() {
	patch -R -p1 < ${FILESDIR}/uucp-patch.diff

	econf
	make \
		sbindir=/usr/sbin \
		bindir=/usr/bin \
		man1dir=/usr/share/man/man1 \
		man8dir=/usr/share/man/man8 \
		newconfigdir=/etc/uucp \
		infodir=/usr/share/info \
		|| die
}

src_install() {
	dodir /usr/share/man/man1
	dodir /usr/share/man/man8
	dodir /usr/share/info
	dodir /etc/uucp
	dodir /usr/bin
	dodir /usr/sbin
	make \
		prefix=${D}/usr \
		sbindir=${D}/usr/sbin \
		bindir=${D}/usr/bin \
		man1dir=${D}/usr/share/man/man1 \
		man8dir=${D}/usr/share/man/man8 \
		newconfigdir=${D}/etc/uucp \
		infodir=${D}/usr/share/info \
		install install-info || die
	dodoc COPYING ChangeLog MANIFEST NEWS README TODO
}
