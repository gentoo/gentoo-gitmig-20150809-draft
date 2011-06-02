# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-gorg/selinux-gorg-2.20101213.ebuild,v 1.2 2011/06/02 12:25:04 blueness Exp $

IUSE=""

MODS="gorg"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for general applications"

KEYWORDS="amd64 x86"

POLICY_PATCH="${FILESDIR}/add-gorg.patch"
RDEPEND=">=sec-policy/selinux-base-policy-2.20101213-r3"
