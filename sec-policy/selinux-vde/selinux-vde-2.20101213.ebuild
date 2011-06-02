# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-vde/selinux-vde-2.20101213.ebuild,v 1.2 2011/06/02 13:07:43 blueness Exp $

IUSE=""

MODS="vde"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for Virtual Distributed Ethernet switch"

KEYWORDS="amd64 x86"

POLICY_PATCH="${FILESDIR}/add-services-vde.patch"
