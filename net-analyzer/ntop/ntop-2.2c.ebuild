# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ntop/ntop-2.2c.ebuild,v 1.5 2004/02/05 15:16:37 aliz Exp $

IUSE="ssl readline tcpd ncurses"

S=${WORKDIR}/${PN}/${PN}
DESCRIPTION="ntop is a unix tool that shows network usage like top"
SRC_URI="mirror://sourceforge/ntop/${P}.tgz"
HOMEPAGE="http://www.ntop.org/ntop.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc hppa ~amd64"

DEPEND=">=sys-libs/gdbm-1.8.0
	>=net-libs/libpcap-0.5.2
	tcpd? ( >=sys-apps/tcp-wrappers-7.6-r4 )
	ssl? ( >=dev-libs/openssl-0.9.6 )
	readline? ( >=sys-libs/readline-4.1 )
	ncurses? ( sys-libs/ncurses )"


src_unpack() {
	unpack ${A}

	cd ${S}/../gdchart0.94c/zlib-1.1.4/
	        epatch ${FILESDIR}/zlib-1.1.4-gzprintf.patch
	        epatch ${FILESDIR}/zlib-1.1.4-glibc.patch
	        epatch ${FILESDIR}/zlib-1.1.4-build-fPIC.patch
	        epatch ${FILESDIR}/zlib-1.1.4-mapfile.patch
		epatch ${FILESDIR}/zlib-1.1.4-build-static-with-fpic.patch

	cd ${S}/../gdchart0.94c/
		epatch ${FILESDIR}/gdchart0.94c-fpic.patch

	cd ${S}/../gdchart0.94c/gd-1.8.3/
		epatch ${FILESDIR}/gd-1.8.3-fpic.patch

	cd ${S}/../gdchart0.94c/gd-1.8.3/libpng-1.2.4/
		epatch ${FILESDIR}/libpng-1.2.4-fpic.patch

}

src_compile() {
	cd ${S}

	local myconf

	use readline	|| myconf="${myconf} --without-readline"
	use tcpd	|| myconf="${myconf} --with-tcpwrap"
	use ssl		|| myconf="${myconf} --without-ssl"
	use ncurses	|| myconf="${myconf} --without-curses"

	# ntop 2.0 ships with its own version of gdchart... gdchart should
	# get its own package but ntop should be built with the version it
	# shipped with just in case future versions are incompatible -- blocke

	# compile gdchart
	einfo "Configure gdchart"
	cd ../gdchart0.94c
	./configure || die "gdchart configure problem"

	# subtree #1
	einfo "Compiling libpng"
	cd gd-1.8.3/libpng-1.2.4
	make -f scripts/makefile.linux CFLAGS="${CFLAGS}" || die "libpng compile problem"

	# subtree #2
	einfo "Compiling zlib"
	cd ../../zlib-1.1.4/
	./configure || die "zlib configure problem"
	make || die "zlib compile problem"

	# gdchart make
	einfo "Compiling gdchart"
	cd ../
	make CFLAGS="${CFLAGS}" || die "gdchart compile problem"

	# now ntop itself...
	einfo "Compiling ntop"
	cd ../ntop
	econf ${myconf} || die "configure problem"
	make || die "compile problem"
}

src_install () {
	make DESTDIR=${D} install || die "install problem"

	# fixme: bad handling of plugins (in /usr/lib with unsuggestive names)
	# (don't know if there is a clean way to handle it)

	doman ntop.8

	dodoc AUTHORS CONTENTS COPYING ChangeLog MANIFESTO NEWS
	dodoc PORTING README SUPPORT_NTOP.txt THANKS docs/*

	dohtml ntop.html

	keepdir /var/lib/ntop

	exeinto /etc/init.d ; newexe ${FILESDIR}/ntop-init ntop
	insinto /etc/conf.d ; newins ${FILESDIR}/ntop-confd ntop
}
