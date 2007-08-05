# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/ldapuserfolder/ldapuserfolder-2.8.ebuild,v 1.2 2007/08/05 02:14:16 aross Exp $

inherit zproduct

DESCRIPTION="LDAP User Authentication for Zope"
HOMEPAGE="http://www.dataflake.org/software/ldapuserfolder/"
SRC_URI="${HOMEPAGE}/${PN}_${PV}/LDAPUserFolder-${PV}.tgz"

LICENSE="ZPL"
KEYWORDS="~ppc ~sparc ~x86 ~amd64"

RDEPEND=">=net-zope/zope-2.8
	>=dev-python/python-ldap-2.0.6"

ZPROD_LIST="LDAPUserFolder"
MYDOC="SAMPLE_RECORDS.txt README.ActiveDirectory.txt COPYRIGHT.txt"
