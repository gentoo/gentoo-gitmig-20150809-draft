# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/isapnptools/isapnptools-1.26.ebuild,v 1.13 2004/06/30 02:45:31 vapier Exp $

DESCRIPTION="Tools for configuring ISA PnP devices"
HOMEPAGE="http://www.roestock.demon.co.uk/isapnptools/"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/system/hardware/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -ppc amd64"
IUSE=""

DEPEND="virtual/libc"

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
