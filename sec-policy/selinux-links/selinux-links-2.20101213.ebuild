# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-links/selinux-links-2.20101213.ebuild,v 1.2 2011/06/02 12:32:23 blueness Exp $

IUSE=""

MODS="links"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for general applications"

KEYWORDS="amd64 x86"
POLICY_PATCH="${FILESDIR}/add-apps-links.patch"
