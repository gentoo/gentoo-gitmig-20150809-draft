# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-gnupg/selinux-gnupg-20041109.ebuild,v 1.1 2004/11/13 19:48:01 kaiowas Exp $

inherit selinux-policy

TEFILES="gpg.te"
FCFILES="gpg.fc"
MACROS="gpg_macros.te"
IUSE=""

DESCRIPTION="SELinux policy for GNU privacy guard"

KEYWORDS="x86 ppc sparc amd64"

