# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-publicfile/selinux-publicfile-20051124.ebuild,v 1.2 2005/12/02 20:09:27 kaiowas Exp $

inherit selinux-policy

TEFILES="publicfile.te"
FCFILES="publicfile.fc"
IUSE=""

RDEPEND="sec-policy/selinux-ucspi-tcp"

DESCRIPTION="SELinux policy for publicfile"

KEYWORDS="amd64 mips ppc sparc x86"

