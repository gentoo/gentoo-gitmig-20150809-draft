# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-snmpd/selinux-snmpd-20041128.ebuild,v 1.2 2005/01/20 09:37:00 kaiowas Exp $

inherit selinux-policy

TEFILES="snmpd.te"
FCFILES="snmpd.fc"
IUSE=""

DESCRIPTION="SELinux policy for snmp daemons"

KEYWORDS="x86 ppc sparc amd64"

