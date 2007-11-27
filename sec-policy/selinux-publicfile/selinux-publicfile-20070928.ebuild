# Copyright 2006-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-publicfile/selinux-publicfile-20070928.ebuild,v 1.1 2007/11/27 02:45:48 pebenito Exp $

MODS="publicfile"
IUSE=""

inherit selinux-policy-2

RDEPEND="sec-policy/selinux-ucspi-tcp"

DESCRIPTION="SELinux policy for publicfile"

KEYWORDS="~alpha ~amd64 ~mips ~ppc ~sparc ~x86"
