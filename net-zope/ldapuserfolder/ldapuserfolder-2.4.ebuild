# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/ldapuserfolder/ldapuserfolder-2.4.ebuild,v 1.2 2004/10/23 22:41:10 lanius Exp $

inherit zproduct
PV_NEW=$(echo ${PV/_/} |sed -e "s:\.:_:g")

DESCRIPTION="LDAP User Authentication for Zope."
HOMEPAGE="http://www.dataflake.org/software/ldapuserfolder/"
SRC_URI="${HOMEPAGE}/${PN}_${PV}/LDAPUserFolder-${PV_NEW}.tgz"
LICENSE="ZPL"
KEYWORDS="x86 ~ppc"
RDEPEND=">=dev-python/python-ldap-2.0.0_pre05
	$RDEPEND"

ZPROD_LIST="LDAPUserFolder"
IUSE=""
