# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/alien/alien-8.21-r1.ebuild,v 1.1 2003/01/26 21:00:29 lordvan Exp $

S=${WORKDIR}/${PN}
IUSE=""
DESCRIPTION="Converts between the rpm, dpkg, stampede slp, and slackware tgz file formats"
SRC_URI="http://kitenet.net/programs/code/alien/${PN}_${PV}.tar.gz"
HOMEPAGE="http://kitenet.net/programs/alien/"
LICENSE="LGPL-2.1"
KEYWORDS="~x86"

SLOT="0"

DEPEND=">=sys-devel/perl-5.6.0
	>=app-arch/rpm-4.0.4-r4
	>=sys-apps/bzip2-1.0.2-r2
	>=app-arch/dpkg-1.10.9"

RDEPEND="${DEPEND}"

src_compile() {
	perl Makefile.PL PREFIX="${D}/usr" || die "configuration failed"
	emake || die "emake failed."
}

src_install() {
	dodir /usr/lib/perl5/site_perl/`perl -e 'printf "%vd", $^V;'`/Alien/Package
	make install PREFIX=${D}/usr \
	    INSTALLMAN1DIR=${D}/usr/share/man/man1 \
	    INSTALLMAN3DIR=${D}/usr/share/man/man3 \
	    VARPREFIX=${D}
	dodoc COPYING INSTALL README TODO
}




