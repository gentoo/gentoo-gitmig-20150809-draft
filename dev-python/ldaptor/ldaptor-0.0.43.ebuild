# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ldaptor/ldaptor-0.0.43.ebuild,v 1.15 2010/03/13 19:14:42 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
DISTUTILS_SRC_TEST="trial"
DISTUTILS_DISABLE_TEST_DEPENDENCY="1"

inherit distutils eutils

DESCRIPTION="set of LDAP utilities for use from the command line"
HOMEPAGE="http://www.inoi.fi/open/trac/ldaptor"
SRC_URI="mirror://debian/pool/main/l/ldaptor/${PN}_${PV}.orig.tar.gz
	doc? ( mirror://gentoo/${PN}-0.0.42-dia-pictures.tar.gz )"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE="web doc samba"

DEPEND=">=dev-python/twisted-2
	dev-python/twisted-names
	dev-python/twisted-mail
	dev-python/pyparsing
	web? (
		>=dev-python/nevow-0.3
		dev-python/twisted-web
		dev-python/webut
	)
	doc? (
		dev-python/epydoc
		dev-libs/libxslt
		app-text/docbook-xsl-stylesheets
	)
	samba? ( dev-python/pycrypto )"
RDEPEND="${DEPEND}"
RESTRICT_PYTHON_ABIS="3.*"

DOCS="README TODO ldaptor.schema"

src_prepare() {
	epatch "${FILESDIR}/${P}-zope_interface.patch"
	epatch "${FILESDIR}/${P}-usage-exception.patch"
}

src_compile() {
	distutils_src_compile
	if use doc; then
		cp "${WORKDIR}/ldaptor-pictures/"*.dia.png doc/
		cd doc
		# skip the slides generation because it doesn't work
		sed -e "/\$(SLIDES:%\.xml=%\/index\.html) /d" -i Makefile
		# replace the docbook.xsl with something that exists
		stylesheet='xsl-stylesheets'
		sed -e "s#stylesheet/xsl/nwalsh#${stylesheet}#" -i Makefile
		emake || die "make failed"
		cd ..
	fi
}

src_test() {
	# Delete test with additional dependencies.
	if ! use web; then
		rm -f ldaptor/test/test_webui.py
	fi

	distutils_src_test
}

src_install() {
	distutils_src_install

	if ! use web; then
		rm -f "${D}"usr/bin/ldaptor-webui*
		rm -fr "${D}"usr/$(get_libdir)/python*/site-packages/ldaptor/apps/webui
	else
		copy_skin-default() {
			cp ldaptor/apps/webui/skin-default.html "${D}$(python_get_sitedir)/ldaptor/apps/webui"
		}
		python_execute_function -q copy_skin-default
	fi

	# Install examples.
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins -r doc/api doc/ldap-intro doc/examples
		if use web; then
			doins -r doc/examples.webui
		fi
	fi
}
