# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-logrotate/selinux-logrotate-20031129.ebuild,v 1.4 2004/04/28 04:03:08 pebenito Exp $

TEFILES="logrotate.te"
FCFILES="logrotate.fc"
IUSE=""

inherit selinux-policy

DESCRIPTION="SELinux policy for logrotate"

KEYWORDS="x86 ppc sparc"

