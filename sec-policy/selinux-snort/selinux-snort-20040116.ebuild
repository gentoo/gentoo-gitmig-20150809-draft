# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-snort/selinux-snort-20040116.ebuild,v 1.2 2004/03/26 21:13:53 aliz Exp $

TEFILES="snort.te"
FCFILES="snort.fc"
IUSE=""

inherit selinux-policy

DESCRIPTION="SELinux policy for snort"

KEYWORDS="x86 ppc sparc"

