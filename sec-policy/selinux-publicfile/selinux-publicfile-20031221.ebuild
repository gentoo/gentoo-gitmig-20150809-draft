# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-publicfile/selinux-publicfile-20031221.ebuild,v 1.3 2004/03/26 21:13:53 aliz Exp $

TEFILES="publicfile.te"
FCFILES="publicfile.fc"
IUSE=""

RDEPEND="sec-policy/selinux-ucspi-tcp"

inherit selinux-policy

DESCRIPTION="SELinux policy for publicfile"

KEYWORDS="x86 ppc sparc"

