# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-gnupg/selinux-gnupg-20050219.ebuild,v 1.2 2005/03/23 07:42:08 kaiowas Exp $

inherit selinux-policy

TEFILES="gpg.te"
FCFILES="gpg.fc"
MACROS="gpg_macros.te"
IUSE=""
RDEPEND=">=sec-policy/selinux-base-policy-20050224"

DESCRIPTION="SELinux policy for GNU privacy guard"

KEYWORDS="x86 ppc sparc amd64"

