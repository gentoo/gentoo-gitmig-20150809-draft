# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/foomatic-db-engine/foomatic-db-engine-3.0.20080507.ebuild,v 1.1 2008/05/07 23:14:38 tgurr Exp $

inherit eutils perl-app versionator

MY_P=${PN}-$(replace_version_separator 2 '-')
DESCRIPTION="Generates ppds out of xml foomatic printer description files"
HOMEPAGE="http://www.linuxprinting.org/foomatic.html"
SRC_URI="http://gentooexperimental.org/~genstef/dist/${MY_P}.tar.gz
	http://www.linuxprinting.org/download/foomatic/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="dev-libs/libxml2
	net-print/foomatic-filters"
PDEPEND="net-print/foomatic-db"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/perl-module-3.0.20070508.diff"
	sed -i -e "s:@LIB_CUPS@:$(cups-config --serverbin):" "${S}"/Makefile.in
}

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"

	cd lib
	perl-app_src_compile
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	cd lib
	perl-module_src_install
}

src_test() {
	cd lib
	perl-module_src_test
}
