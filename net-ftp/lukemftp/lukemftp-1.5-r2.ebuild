# Copyright 2000-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Donny Davies <woodchip@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-ftp/lukemftp/lukemftp-1.5-r2.ebuild,v 1.1 2001/09/25 19:38:07 woodchip Exp $

S=${WORKDIR}/${P}
DESCRIPTION="NetBSD FTP client with several advanced features"
SRC_URI="ftp://ftp.netbsd.org/pub/NetBSD/misc/lukemftp/${P}.tar.gz"

DEPEND="virtual/glibc
        >=sys-libs/ncurses-5.1"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Adds a command line option: -s, which produces clean, informative output.
	# Shows progess status, ETA, transfer speed, no server responses or login messages.
	# ~woodchip
	cp src/main.c src/main.orig
	sed -e "s/Aadefgino:pP:r:RtT:u:vV/Aadefgino:pP:r:RstT:u:vV/" \
		-e "s/case 't'/case 's':\n\t\t\tverbose = 0;\n\t\t\tprogress = 1;\n\t\t\tbreak;\n\n\t\t&/" \
		src/main.orig > src/main.c
}

src_compile() {
	local myconf
	use ipv6 || myconf="${myconf} --disable-ipv6"

	./configure --host=${CHOST} --prefix=/usr --enable-editcomplete ${myconf}
	assert ; make ; assert "compile problem :("
}

src_install() {
	dodoc COPYING ChangeLog README* THANKS NEWS
	newbin src/ftp lukemftp
	newman src/ftp.1 lukemftp.1

	if [ ! -e /usr/bin/ftp ]; then
		cd ${D}/usr/bin
		ln -s lukemftp ftp
	fi
}
