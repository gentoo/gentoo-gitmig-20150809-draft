# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-logrotate/selinux-logrotate-20031129.ebuild,v 1.2 2003/11/29 21:30:32 pebenito Exp $

TEFILES="logrotate.te"
FCFILES="logrotate.fc"

inherit selinux-policy

DESCRIPTION="SELinux policy for logrotate"

KEYWORDS="x86 ppc"

