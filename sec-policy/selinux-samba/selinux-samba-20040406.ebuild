# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-samba/selinux-samba-20040406.ebuild,v 1.1 2004/04/06 20:20:23 pebenito Exp $

TEFILES="courier-imap.te"
FCFILES="courier-imap.fc"
IUSE=""

inherit selinux-policy

DESCRIPTION="SELinux policy for samba"

KEYWORDS="x86 ppc sparc"

