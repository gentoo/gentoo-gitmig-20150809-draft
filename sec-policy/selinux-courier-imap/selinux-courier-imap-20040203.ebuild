# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-courier-imap/selinux-courier-imap-20040203.ebuild,v 1.3 2004/06/28 00:10:37 pebenito Exp $

TEFILES="courier-imap.te"
FCFILES="courier-imap.fc"
IUSE=""

inherit selinux-policy

DESCRIPTION="SELinux policy for courier-imap"

KEYWORDS="x86 ppc sparc"

