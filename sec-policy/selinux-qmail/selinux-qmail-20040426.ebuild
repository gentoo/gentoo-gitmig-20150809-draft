# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-qmail/selinux-qmail-20040426.ebuild,v 1.3 2004/09/20 01:55:47 pebenito Exp $

TEFILES="qmail.te"
FCFILES="qmail.fc"
IUSE=""

inherit selinux-policy

DESCRIPTION="SELinux policy for qmail"

KEYWORDS="x86 ppc sparc amd64"

