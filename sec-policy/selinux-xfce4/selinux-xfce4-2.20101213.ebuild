# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-xfce4/selinux-xfce4-2.20101213.ebuild,v 1.2 2011/06/02 13:11:14 blueness Exp $

IUSE=""

MODS="xfce4"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for XFCE4 desktop environment"

KEYWORDS="amd64 x86"

POLICY_PATCH="${FILESDIR}/add-apps-xfce4.patch"
