# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-qmail/selinux-qmail-20040205.ebuild,v 1.2 2004/03/26 21:13:53 aliz Exp $

TEFILES="qmail.te"
FCFILES="qmail.fc"
IUSE=""

inherit selinux-policy

DESCRIPTION="SELinux policy for qmail"

KEYWORDS="x86 ppc sparc"

