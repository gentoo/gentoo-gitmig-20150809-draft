# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-gnupg/selinux-gnupg-20050119.ebuild,v 1.1 2005/01/20 10:31:03 kaiowas Exp $

inherit selinux-policy

TEFILES="gpg.te"
FCFILES="gpg.fc"
MACROS="gpg_macros.te"
IUSE=""

DESCRIPTION="SELinux policy for GNU privacy guard"

KEYWORDS="~x86 ~ppc ~sparc ~amd64"

