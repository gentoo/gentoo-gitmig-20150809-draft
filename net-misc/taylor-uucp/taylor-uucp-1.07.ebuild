# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/taylor-uucp/taylor-uucp-1.07.ebuild,v 1.11 2004/03/27 22:09:01 vapier Exp $

inherit eutils

S=${WORKDIR}/uucp-1.07	# This should be a .2 bug the package is messed
DESCRIPTION="Taylor UUCP"
HOMEPAGE="http://www.airs.com/ian/uucp.html"
SRC_URI="ftp://ftp.gnu.org/pub/gnu/uucp/uucp-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc sparc alpha ~amd64 ia64"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/gentoo-uucp-${PV}.patch
}

src_compile() {
	econf --with-newconfigdir=/etc/uucp || die
	make || die
}

src_install() {
	dodir /usr/share/man/man{1,8}
	dodir /usr/share/info
	dodir /etc/uucp
	dodir /usr/bin /usr/sbin
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
	dodoc ChangeLog NEWS README TODO

	chmod -R 775 ${D}/var/lock/uucp
	chown -R root:uucp ${D}/var/lock/uucp
}

pkg_preinst() {
	usermod -s /bin/bash uucp
}
