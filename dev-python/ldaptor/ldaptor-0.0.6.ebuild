# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ldaptor/ldaptor-0.0.6.ebuild,v 1.9 2003/09/11 01:14:04 msterret Exp $

DESCRIPTION="set of LDAP utilities for use from the command line"
HOMEPAGE="http://twistedmatrix.com/users/tv/ldaptor/"
SRC_URI="http://twistedmatrix.com/users/tv/ldaptor/${PN}_${PV}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ~alpha ~sparc"

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
