# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-qmail/selinux-qmail-20041018.ebuild,v 1.1 2004/10/23 09:25:21 kaiowas Exp $

inherit selinux-policy

TEFILES="qmail.te"
FCFILES="qmail.fc"
IUSE=""

DESCRIPTION="SELinux policy for qmail"

KEYWORDS="~x86 ~ppc ~sparc ~amd64"

