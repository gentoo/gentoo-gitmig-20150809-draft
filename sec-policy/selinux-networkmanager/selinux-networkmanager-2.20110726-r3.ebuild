# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-networkmanager/selinux-networkmanager-2.20110726-r3.ebuild,v 1.2 2012/02/23 18:44:01 swift Exp $
EAPI="4"

IUSE=""
MODS="networkmanager"
BASEPOL="2.20110726-r11"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for networkmanager"
KEYWORDS="amd64 x86"
