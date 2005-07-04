# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ldaptor/ldaptor-0.0.41.ebuild,v 1.1 2005/07/04 16:01:15 lordvan Exp $

inherit distutils

DESCRIPTION="set of LDAP utilities for use from the command line"
HOMEPAGE="http://www.inoi.fi/open/trac/ldaptor"
SRC_URI="http://ftp.debian.org/debian/pool/main/l/ldaptor/${PN}_${PV}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE="web doc samba"

DEPEND=">=dev-python/twisted-2
	dev-python/twisted-names
	dev-python/twisted-mail
	dev-python/pyparsing
	web? ( >=dev-python/nevow-0.3 )
	doc? (
		dev-python/epydoc
		app-office/dia
		dev-libs/libxslt
		app-text/docbook-xsl-stylesheets
	)
	samba? ( dev-python/pycrypto )"

DOCS="README TODO ldaptor.schema"

src_unpack() {
	unpack ${A}
	if [ -f ${FILESDIR}/${P}-svn-update.patch ]; then
		epatch ${FILESDIR}/${P}-svn-update.patch
	fi
}

src_compile() {
	distutils_src_compile
	if use doc; then
		cd doc
		# skip the slides generation because it doesn't work
		sed -e "/\$(SLIDES:%\.xml=%\/index\.html) /d" -i Makefile
		# replace the docbook.xsl with something that exists
		stylesheet=$(portageq best_version / app-text/docbook-xsl-stylesheets)
		stylesheet=${stylesheet#app-text/docbook-}
		sed -e "s#stylesheet/xsl/nwalsh#${stylesheet}#" -i Makefile
		emake || die "make failed"
		cd ..
	fi
}

src_install() {
	distutils_src_install

	python_version

	if ! use web; then
		rm ${D}/usr/bin/ldaptor-webui || die "couldn't rm ldaptor-webui"
		rm -rf ${D}/usr/lib/python${PYVER}/site-packages/ldaptor/apps/webui || die "couldn't prune webui"
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

src_test() {
	trial -R ldaptor || die "test failed"
}
