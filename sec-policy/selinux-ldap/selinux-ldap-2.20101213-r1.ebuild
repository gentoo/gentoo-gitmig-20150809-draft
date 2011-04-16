# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-ldap/selinux-ldap-2.20101213-r1.ebuild,v 1.1 2011/04/16 13:25:34 blueness Exp $

MODS="ldap"
IUSE=""

inherit selinux-policy-2

DESCRIPTION="SELinux policy for OpenLDAP server"

KEYWORDS="~amd64 ~x86"
RDEPEND="!<=sec-policy/selinux-openldap-2.20101213
		>=sys-apps/policycoreutils-1.30.30
		>=sec-policy/selinux-base-policy-${PV}"

POLICY_PATCH="${FILESDIR}/fix-services-ldap-r1.patch"
