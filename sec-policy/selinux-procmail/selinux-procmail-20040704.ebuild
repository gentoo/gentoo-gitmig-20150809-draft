# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-procmail/selinux-procmail-20040704.ebuild,v 1.1 2004/07/05 02:49:50 pebenito Exp $

TEFILES="procmail.te"
FCFILES="procmail.fc"
IUSE=""

inherit selinux-policy

DESCRIPTION="SELinux policy for procmail"

KEYWORDS="x86 ppc sparc"

