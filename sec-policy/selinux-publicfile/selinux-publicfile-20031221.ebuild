# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-publicfile/selinux-publicfile-20031221.ebuild,v 1.6 2004/09/20 01:55:47 pebenito Exp $

TEFILES="publicfile.te"
FCFILES="publicfile.fc"
IUSE=""

RDEPEND="sec-policy/selinux-ucspi-tcp"

inherit selinux-policy

DESCRIPTION="SELinux policy for publicfile"

KEYWORDS="x86 ppc sparc amd64"

