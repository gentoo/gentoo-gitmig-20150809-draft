# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-qmail/selinux-qmail-20041120.ebuild,v 1.1 2004/11/22 21:04:59 kaiowas Exp $

inherit selinux-policy

TEFILES="qmail.te"
FCFILES="qmail.fc"
IUSE=""

DESCRIPTION="SELinux policy for qmail"

KEYWORDS="~x86 ~ppc ~sparc ~amd64"

