# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-openvpn/selinux-openvpn-20050618.ebuild,v 1.1 2005/06/26 18:29:44 kaiowas Exp $

inherit selinux-policy

TEFILES="openvpn.te"
FCFILES="openvpn.fc"
IUSE=""

DESCRIPTION="SELinux policy for OpenVPN"

KEYWORDS="~x86 ~ppc ~sparc ~amd64"

