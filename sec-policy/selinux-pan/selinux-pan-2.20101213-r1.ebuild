# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-pan/selinux-pan-2.20101213-r1.ebuild,v 1.1 2011/08/07 11:10:33 blueness Exp $

IUSE=""

MODS="pan"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for general applications"

KEYWORDS="~amd64 ~x86"

POLICY_PATCH="${FILESDIR}/fix-apps-pan-r1.patch"
RDEPEND=">=sec-policy/selinux-base-policy-2.20101213-r22"
