# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/zebedee/zebedee-2.5.2.ebuild,v 1.8 2005/04/01 16:26:08 agriffis Exp $

DESCRIPTION="A simple, free, secure TCP and UDP tunnel program"
HOMEPAGE="http://www.winton.org.uk/zebedee/"
SRC_URI="mirror://sourceforge/zebedee/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc alpha ~hppa ~mips ia64 ~amd64 ~ppc64 s390"
IUSE=""


DEPEND="dev-lang/perl
	dev-libs/openssl
	sys-libs/zlib
	app-arch/bzip2"

src_compile() {
	emake \
		BFINC=-I/usr/include/openssl \
		BFLIB=-lcrypto \
		ZINC=-I/usr/include \
		ZLIB=-lz \
		BZINC=-I/usr/include \
		BZLIB=-lbz2 \
		OS=linux || die
}

src_install() {
	make \
		ROOTDIR=${D}/usr \
		MANDIR=${D}/usr/share/man/man1 \
		ZBDDIR=${D}/etc/zebedee \
		OS=linux \
		install || die

	rm -f ${D}/etc/zebedee/*.{txt,html}

	dodoc *.txt
	dohtml *.html

	exeinto /etc/init.d
	doexe ${FILESDIR}/zebedee
}

pkg_postinst() {
	echo
	einfo "Before you use the Zebedee rc script (/etc/init.d/zebedee), it is"
	einfo "recommended that you edit the server config file: "
	einfo "(/etc/zebedee/server.zbd)."
	einfo "the \"detached\" directive should remain set to false;"
	einfo "the rc script takes care of backgrounding automatically."
	echo
}
