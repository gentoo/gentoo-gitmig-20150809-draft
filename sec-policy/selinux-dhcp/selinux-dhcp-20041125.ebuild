# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-dhcp/selinux-dhcp-20041125.ebuild,v 1.1 2004/12/12 12:09:39 kaiowas Exp $

inherit selinux-policy

TEFILES="dhcpd.te"
FCFILES="dhcpd.fc"
IUSE=""

DESCRIPTION="SELinux policy for dhcp server"

KEYWORDS="~x86 ~ppc ~sparc ~amd64"

RDEPEND=">=sec-policy/selinux-base-policy-20041023"

