# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ldaptor/ldaptor-0.0.6.ebuild,v 1.15 2005/08/26 14:20:55 agriffis Exp $

DESCRIPTION="set of LDAP utilities for use from the command line"
HOMEPAGE="http://twistedmatrix.com/users/tv/ldaptor/"
SRC_URI="http://twistedmatrix.com/users/tv/ldaptor/${PN}_${PV}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha ~ia64 ppc ~sparc x86"
IUSE=""

DEPEND=">=dev-python/twisted-1.0.1-r1"

src_compile() {
	python setup-ldaptor-utils.py build || \
		die "compilation of ldaptor-utils failed"
	python setup-ldaptor-webui.py build || \
		die "compilation of ldaptor-webui failed"
	python setup-python-ldaptor.py build || \
		die "compilation of python-ldaptor failed"
}

src_install() {
	python setup-ldaptor-utils.py install --root=${D} || die
	python setup-ldaptor-webui.py install --root=${D} || die
	python setup-python-ldaptor.py install --root=${D} || die

	dodoc README TODO rfc2251-status.txt

	# install examples
	dodir /usr/share/doc/${PF}/examples
	insinto /usr/share/doc/${PF}/examples
	doins examples/*

	# install tests
	dodir /usr/share/doc/${PF}/tests
	insinto /usr/share/doc/${PF}/tests
	doins tests/*
}
