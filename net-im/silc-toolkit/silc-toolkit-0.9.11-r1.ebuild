# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/silc-toolkit/silc-toolkit-0.9.11-r1.ebuild,v 1.2 2004/03/19 08:13:08 dholm Exp $

IUSE="client server debug ipv6 perl socks5"

DESCRIPTION="Software development toolkit which provides full SILC protocol implementation for application developers."
HOMEPAGE="http://silcnet.org"
SRC_URI="http://silcnet.org/download/toolkit/sources/silc-toolkit-${PV}.tar.bz2"
KEYWORDS="~x86 ~sparc ~ppc"
LICENSE="GPL-2"

SLOT="0"

DEPEND="virtual/glibc
	client? ( !net-im/silc-client )
	client? ( sys-libs/ncurses )
	client? ( =dev-libs/glib-1.2* )
	socks5? ( net-misc/dante )
	perl? ( dev-lang/perl )"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
}

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
		&& myconf="${myconf} --with-ncurses" \
		|| myconf="${myconf} --without-irssi"

	use server \
		&& myconf="${myconf}" \
		|| myconf="${myconf} --without-silcd"

	econf ${myconf} || die "./configure failed"
	make || die "make failed"
}

src_install() {
	if [ -z "`use client`" ]
	then
		if [ -z "`use perl`" ]
		then
			R1="s/installsitearch='//"
			R2="s/';//"
			perl_sitearch="`perl -V:installsitearch | sed -e ${R1} -e ${R2}`"
			myflags="${myflags} INSTALLPRIVLIB=/usr/lib"
			myflags="${myflags} INSTALLARCHLIB=${perl_sitearch}"
			myflags="${myflags} INSTALLSITELIB=${perl_sitearch}"
			myflags="${myflags} INSTALLSITEARCH=${perl_sitearch}"
		fi
	fi

	make install || die "make install failed"
	mv ${D}/usr/tutorial ${D}/usr/share/doc/${P}
}
