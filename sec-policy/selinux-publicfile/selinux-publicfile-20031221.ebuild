# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-publicfile/selinux-publicfile-20031221.ebuild,v 1.2 2003/12/21 17:45:23 pebenito Exp $

TEFILES="publicfile.te"
FCFILES="publicfile.fc"

RDEPEND="sec-policy/selinux-ucspi-tcp"

inherit selinux-policy

DESCRIPTION="SELinux policy for publicfile"

KEYWORDS="x86 ppc sparc"

