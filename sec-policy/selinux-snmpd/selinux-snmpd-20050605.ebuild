# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-snmpd/selinux-snmpd-20050605.ebuild,v 1.2 2005/06/27 11:27:38 kaiowas Exp $

inherit selinux-policy

TEFILES="snmpd.te"
FCFILES="snmpd.fc"
IUSE=""
RDEPEND=">=sec-policy/selinux-base-policy-20050224"

DESCRIPTION="SELinux policy for snmp daemons"

KEYWORDS="x86 ppc sparc amd64"

