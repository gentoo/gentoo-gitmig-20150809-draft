# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/foomatic-db-engine/foomatic-db-engine-3.0.0.ebuild,v 1.1 2003/07/16 14:44:17 lanius Exp $

inherit perl-module

DESCRIPTION="Foomatic printer database engine"
HOMEPAGE="http://www.linuxprinting.org/foomatic"
SRC_URI="http://www.linuxprinting.org/download/foomatic/foomatic-db-engine-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
IUSE=""

DEPEND="dev-libs/libxml2
	net-misc/wget
	net-ftp/curl
	net-print/foomatic-filters"

src_compile() {
	epatch ${FILESDIR}/perl-module.diff
	econf
	emake || die
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
