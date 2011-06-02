# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-courier/selinux-courier-2.20101213-r3.ebuild,v 1.2 2011/06/02 12:12:15 blueness Exp $

MODS="courier"
IUSE=""

inherit selinux-policy-2

DESCRIPTION="SELinux policy for courier-imap"

KEYWORDS="amd64 x86"
RDEPEND="!<=sec-policy/selinux-courier-imap-2.20101213
		>=sys-apps/policycoreutils-1.30.30
		>=sec-policy/selinux-base-policy-${PV}"

POLICY_PATCH="${FILESDIR}/fix-services-courier-r3.patch"
