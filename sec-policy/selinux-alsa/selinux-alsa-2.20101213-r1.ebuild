# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-alsa/selinux-alsa-2.20101213-r1.ebuild,v 1.2 2011/06/02 12:02:32 blueness Exp $

IUSE=""

MODS="alsa"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for general applications"

KEYWORDS="amd64 x86"

POLICY_PATCH="${FILESDIR}/fix-alsa.patch"
