# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/ldapuserfolder/ldapuserfolder-2.1_beta3.ebuild,v 1.4 2004/09/11 21:42:11 lanius Exp $

inherit zproduct
PV_NEW=$(echo ${PV/_/} |sed -e "s:\.:_:g")

DESCRIPTION="LDAP User Authentication for Zope."
HOMEPAGE="http://www.dataflake.org/software/ldapuserfolder/"
SRC_URI="${HOMEPAGE}LDAPUserFolder-${PV_NEW}.tgz"
LICENSE="ZPL"
KEYWORDS="x86 ~ppc"
RDEPEND=">=dev-python/python-ldap-py21-2.0.0_pre05
	$RDEPEND"

ZPROD_LIST="LDAPUserFolder"
IUSE=""
