# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-daemontools/selinux-daemontools-20031221.ebuild,v 1.1 2003/12/21 06:50:01 pebenito Exp $

TEFILES="daemontools.te"
FCFILES="daemontools.fc"
MACROS="daemontools_macros.te"

inherit selinux-policy

DESCRIPTION="SELinux policy for daemontools"

KEYWORDS="x86 ppc sparc"

