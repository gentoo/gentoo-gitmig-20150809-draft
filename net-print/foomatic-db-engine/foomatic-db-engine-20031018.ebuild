# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/foomatic-db-engine/foomatic-db-engine-20031018.ebuild,v 1.2 2003/12/10 18:31:04 lanius Exp $

inherit perl-module

DESCRIPTION="Foomatic printer database engine"
HOMEPAGE="http://www.linuxprinting.org/foomatic"
SRC_URI="http://www.linuxprinting.org/download/foomatic/${PN}-3.0-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa amd64"
IUSE=""

S=${WORKDIR}/${PN}-3.0-${PV}

DEPEND="dev-libs/libxml2
	net-misc/wget
	net-ftp/curl
	net-print/foomatic-filters"

src_compile() {
	epatch ${FILESDIR}/perl-module.diff
	econf
	make || die
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	# install perl modules
	cd lib
	perl-module_src_prep
	perl-module_src_compile
	perl-module_src_test
	perl-module_src_install
}
