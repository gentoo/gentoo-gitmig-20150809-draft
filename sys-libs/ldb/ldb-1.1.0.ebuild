# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/ldb/ldb-1.1.0.ebuild,v 1.1 2011/08/04 18:33:24 maksbotan Exp $

EAPI="3"
PYTHON_DEPEND="2"

inherit python waf-utils multilib

DESCRIPTION="An LDAP-like embedded database"
HOMEPAGE="http://ldb.samba.org"
SRC_URI="http://www.samba.org/ftp/pub/${PN}/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="dev-libs/popt
	>=sys-libs/talloc-2.0.0
	sys-libs/tdb
	sys-libs/tevent
	net-nds/openldap"

DEPEND="dev-libs/libxslt
	doc? ( app-doc/doxygen )
	${RDEPEND}"

WAF_BINARY="${S}/buildtools/bin/waf-svn"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_configure() {
	econf \
		--disable-rpath \
		--disable-rpath-install \
		--bundled-libraries=NONE \
		--with-modulesdir="${EPRFIX}"/usr/$(get_libdir)/ldb/modules \
		--with-privatelibdir="${EPRFIX}"/usr/$(get_libdir)/ldb \
		--builtin-libraries=NONE ||die
}

src_compile(){
	waf-utils_src_compile
	use doc && doxygen Doxyfile
}

src_install() {
	waf-utils_src_install
	rm "${D}/$(python_get_sitedir)/"_tevent.so

	if use doc; then
		dohtml -r apidocs/html/*
		doman  apidocs/man/man3/*.3
	fi
}
