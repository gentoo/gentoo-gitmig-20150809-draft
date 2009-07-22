# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-wireshark/selinux-wireshark-20060720.ebuild,v 1.4 2009/07/22 13:12:37 pebenito Exp $

inherit selinux-policy

TEFILES="wireshark.te"
FCFILES="wireshark.fc"
MACROS="wireshark_macros.te"
IUSE=""
RDEPEND=">=sec-policy/selinux-base-policy-20050618"

DESCRIPTION="SELinux policy for wireshark"

KEYWORDS="amd64 x86"
