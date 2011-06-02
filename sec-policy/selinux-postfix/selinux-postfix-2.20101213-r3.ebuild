# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-postfix/selinux-postfix-2.20101213-r3.ebuild,v 1.2 2011/06/02 12:45:20 blueness Exp $

MODS="postfix"
IUSE=""

inherit selinux-policy-2

DESCRIPTION="SELinux policy for postfix"

KEYWORDS="amd64 x86"

POLICY_PATCH="${FILESDIR}/fix-services-postfix-r3.patch"
