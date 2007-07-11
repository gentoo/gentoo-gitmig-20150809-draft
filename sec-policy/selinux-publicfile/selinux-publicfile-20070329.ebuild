# Copyright 2006-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-publicfile/selinux-publicfile-20070329.ebuild,v 1.3 2007/07/11 02:56:48 mr_bones_ Exp $

MODS="publicfile"
IUSE=""

inherit selinux-policy-2

RDEPEND="sec-policy/selinux-ucspi-tcp"

DESCRIPTION="SELinux policy for publicfile"

KEYWORDS="alpha amd64 mips ppc sparc x86"
