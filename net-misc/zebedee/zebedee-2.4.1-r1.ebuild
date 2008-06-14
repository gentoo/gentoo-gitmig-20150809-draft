# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/zebedee/zebedee-2.4.1-r1.ebuild,v 1.4 2008/06/14 03:35:44 darkside Exp $

MY_P="${P}A"
DESCRIPTION="A simple, free, secure TCP and UDP tunnel program"
HOMEPAGE="http://www.winton.org.uk/zebedee/"
SRC_URI="http://www.winton.org.uk/zebedee/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ppc64 ~sparc x86"
IUSE=""

DEPEND="dev-lang/perl
	dev-libs/openssl
	sys-libs/zlib
	app-arch/bzip2"

S="${WORKDIR}/${MY_P}"

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

	rm -f "${D}"/etc/zebedee/*.{txt,html}

	dodoc *.txt
	dohtml *.html

	doinitd "${FILESDIR}"/zebedee
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
