# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-postfix/selinux-postfix-20040427.ebuild,v 1.1 2004/04/28 03:58:47 pebenito Exp $

TEFILES="postfix.te"
FCFILES="postfix.fc"
IUSE=""

inherit selinux-policy

DESCRIPTION="SELinux policy for postfix"

KEYWORDS="x86 ppc sparc"

