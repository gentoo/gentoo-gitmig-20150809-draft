# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/silc-toolkit/silc-toolkit-0.9.12.ebuild,v 1.8 2004/07/15 00:26:05 agriffis Exp $

DESCRIPTION="SDK for the SILC protocol"
HOMEPAGE="http://silcnet.org/"
SRC_URI="http://silcnet.org/download/toolkit/sources/silc-toolkit-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~hppa ~amd64 ~alpha ~ia64"
IUSE="client ipv6 server"

DEPEND="virtual/libc
	!net-im/silc-client"
RDEPEND="virtual/libc"

src_compile() {
	local myconf

	myconf="--prefix=${D}/usr \
		--datadir=${D}/usr/share/silc \
		--mandir=${D}/usr/man \
		--includedir=${D}/usr/include/${PN} \
		--sysconfdir=${D}/usr/share/silc/etc \
		--with-etcdir=${D}/etc/silc \
		--with-simdir=${D}/usr/share/silc/modules \
		--with-docdir=${D}/usr/share/doc/${P} \
		--with-logsdir=${D}/var/log/silc"

	if [ "${DEBUG}" ]
	then
		einfo "debugging"
		myconf="${myconf} --enable-debug"
	fi

	use ipv6 \
		&& myconf="${myconf} --enable-ipv6"

	use client \
		&& myconf="${myconf}" \
		|| myconf="${myconf} --without-irssi"

	use server \
		&& myconf="${myconf}" \
		|| myconf="${myconf} --without-silcd"

	econf ${myconf} || die "./configure failed"
	make || die "make failed"
}

src_install() {
	make install
	mv ${D}/usr/tutorial ${D}/usr/share/doc/${P}
}
