# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-courier-imap/selinux-courier-imap-20040406.ebuild,v 1.1 2004/04/06 20:14:01 pebenito Exp $

TEFILES="courier-imap.te"
FCFILES="courier-imap.fc"
IUSE=""

inherit selinux-policy

DESCRIPTION="SELinux policy for courier-imap"

KEYWORDS="x86 ppc sparc"

