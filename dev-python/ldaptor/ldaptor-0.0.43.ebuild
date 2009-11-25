# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ldaptor/ldaptor-0.0.43.ebuild,v 1.13 2009/11/25 22:16:57 maekke Exp $

inherit distutils

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
		dev-python/webut
		>=dev-python/nevow-0.3
		dev-python/twisted-web
	)
	doc? (
		dev-python/epydoc
		dev-libs/libxslt
		app-text/docbook-xsl-stylesheets
	)
	samba? ( dev-python/pycrypto )"
RDEPEND="${DEPEND}"

DOCS="README TODO ldaptor.schema"

src_unpack() {
	unpack ${A}
	cd "${S}"
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
	PYTHONPATH=. trial ldaptor || die "test failed"
}

src_install() {
	distutils_src_install

	if ! use web; then
		rm "${D}"/usr/bin/ldaptor-webui || die "couldn't rm ldaptor-webui"
		rm -rf "${D}"/$(python_get_sitedir)/ldaptor/apps/webui || die "couldn't prune webui"
	else
		cp ldaptor/apps/webui/skin-default.html "${D}"/$(python_get_sitedir)/ldaptor/apps/webui \
			|| die "couldn't copy default skin"
	fi

	# install examples
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins -r doc/api doc/ldap-intro doc/examples
		if use web; then
			doins -r doc/examples.webui
		fi
	fi
}
