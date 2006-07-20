# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-wireshark/selinux-wireshark-20060720.ebuild,v 1.1 2006/07/20 13:34:32 kaiowas Exp $

inherit selinux-policy

TEFILES="wireshark.te"
FCFILES="wireshark.fc"
MACROS="wireshark_macros.te"
IUSE=""
RDEPEND=">=sec-policy/selinux-base-policy-20050618"

DESCRIPTION="SELinux policy for wireshark"

KEYWORDS="~amd64 ~mips ~ppc ~sparc ~x86"

