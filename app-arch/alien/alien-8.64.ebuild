# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/alien/alien-8.64.ebuild,v 1.2 2006/12/01 20:00:06 wolf31o2 Exp $

DESCRIPTION="Converts between the rpm, dpkg, stampede slp, and slackware tgz file formats"
HOMEPAGE="http://kitenet.net/programs/alien/"
SRC_URI="ftp://ftp.debian.org/debian/pool/main/a/alien/${PN}_${PV}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ~ppc x86"
IUSE=""

DEPEND=">=dev-lang/perl-5.6.0
	>=app-arch/rpm-4.0.4-r4
	>=app-arch/bzip2-1.0.2-r2
	>=app-arch/dpkg-1.10.9"

S=${WORKDIR}/${PN}

src_compile() {
	perl Makefile.PL PREFIX="${D}/usr" || die "configuration failed"
	emake || die "emake failed."
}

src_install() {
	dodir /usr/lib/perl5/site_perl/`perl -e 'printf "%vd", $^V;'`/Alien/Package
	make install \
		PREFIX=${D}/usr \
		INSTALLMAN1DIR=${D}/usr/share/man/man1 \
		INSTALLMAN3DIR=${D}/usr/share/man/man3 \
		VARPREFIX=${D}
	dodoc INSTALL README TODO
}
