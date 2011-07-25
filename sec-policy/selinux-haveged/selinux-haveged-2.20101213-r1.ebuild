# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-haveged/selinux-haveged-2.20101213-r1.ebuild,v 1.1 2011/07/25 22:58:54 blueness Exp $

IUSE=""

MODS="haveged"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for general applications"

DEPEND=">=sec-policy/selinux-base-policy-2.20101213-r19"
RDEPEND="${DEPEND}"

KEYWORDS="~amd64 ~x86"

POLICY_PATCH="${FILESDIR}/fix-services-haveged-r1.patch"
