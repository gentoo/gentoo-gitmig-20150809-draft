# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/isapnptools/isapnptools-1.26.ebuild,v 1.11 2003/06/21 21:19:40 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Tools for configuring ISA PnP devices"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/system/hardware/${P}.tgz"
HOMEPAGE="http://www.roestock.demon.co.uk/isapnptools/"
KEYWORDS="x86 amd64 -ppc"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}/src
	cp pnpdump_main.c pnpdump_main.c.orig
	sed -e "s/^static FILE\* o_file.*//" \
		-e "s/o_file/stdout/g" \
		-e "s/stdout_name/o_file_name/g" \
		pnpdump_main.c.orig > pnpdump_main.c
}

src_compile() {
	./configure --prefix=/usr \
		--mandir=/usr/share/man \
		--host=${CHOST} || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS ChangeLog COPYING README NEWS
	docinto txt
	dodoc doc/README*  doc/*.txt test/*.txt
	dodoc etc/isapnp.*

	exeinto /etc/init.d
	newexe ${FILESDIR}/isapnp.rc6 isapnp
}
