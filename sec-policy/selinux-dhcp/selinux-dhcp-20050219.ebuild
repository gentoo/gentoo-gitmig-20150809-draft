# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-dhcp/selinux-dhcp-20050219.ebuild,v 1.2 2005/03/23 07:38:05 kaiowas Exp $

inherit selinux-policy

TEFILES="dhcpd.te"
FCFILES="dhcpd.fc"
IUSE=""

DESCRIPTION="SELinux policy for dhcp server"

KEYWORDS="x86 ppc sparc amd64"

