# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/foomatic-db-engine/foomatic-db-engine-3.0.20060601.ebuild,v 1.1 2006/06/04 14:55:08 genstef Exp $

inherit perl-app eutils versionator autotools

MY_P=${PN}-$(replace_version_separator 2 '-')
DESCRIPTION="Foomatic printer database engine"
HOMEPAGE="http://www.linuxprinting.org/foomatic.html"
SRC_URI="http://gentooexperimental.org/~genstef/dist/${MY_P}.tar.gz"
#http://www.linuxprinting.org/download/foomatic/

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE=""

RDEPEND="dev-libs/libxml2
	net-print/foomatic-filters"
PDEPEND="net-print/foomatic-db"
S=${WORKDIR}/${MY_P}

src_compile() {
	epatch ${FILESDIR}/perl-module-3.0.1.diff
	econf || die
	make || die
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	# install perl modules
	cd lib
	perl-app_src_prep
	perl-app_src_compile
	perl-module_src_test
	perl-module_src_install
}
