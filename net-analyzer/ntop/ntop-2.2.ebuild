# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ntop/ntop-2.2.ebuild,v 1.1 2003/05/04 14:31:39 aliz Exp $

IUSE="ssl readline tcpd ncurses"

S=${WORKDIR}/${P}/${PN}
DESCRIPTION="ntop is a unix tool that shows network usage like top"
SRC_URI="mirror://sourceforge/ntop/${P}.tgz"
HOMEPAGE="http://www.ntop.org/ntop.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc"

DEPEND=">=sys-libs/gdbm-1.8.0
	>=net-libs/libpcap-0.5.2
	tcpd? ( >=sys-apps/tcp-wrappers-7.6-r4 )
	ssl? ( >=dev-libs/openssl-0.9.6 )
	readline? ( >=sys-libs/readline-4.1 )
	ncurses? ( sys-libs/ncurses )"

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
	cd ../gdchart0.94c
	./configure || die "gdchart configure problem"

	# subtree #1
	cd gd-1.8.3/libpng-1.2.4
	make -f scripts/makefile.linux || die "libpng compile problem"

	# subtree #2
	cd ../../zlib-1.1.4/
	./configure || die "zlib configure problem"
	make || die "zlib compile problem"

	# gdchart make
	cd ../
	make || die "gdchart compile problem"

	# now ntop itself...
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
	dodoc PORTING README SUPPORT_NTOP.txt THANKS

	dohtml ntop.html

	dodir /var/lib/ntop

	exeinto /etc/init.d ; newexe ${FILESDIR}/ntop-init ntop
	insinto /etc/conf.d ; newins ${FILESDIR}/ntop-confd ntop
}

