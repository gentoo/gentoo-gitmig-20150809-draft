# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-openvpn/selinux-openvpn-20050618.ebuild,v 1.2 2005/08/20 17:48:14 kaiowas Exp $

inherit selinux-policy

TEFILES="openvpn.te"
FCFILES="openvpn.fc"
IUSE=""

DESCRIPTION="SELinux policy for OpenVPN"

KEYWORDS="x86 ppc sparc amd64 mips"

