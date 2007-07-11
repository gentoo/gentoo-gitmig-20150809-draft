# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-courier-imap/selinux-courier-imap-20050628.ebuild,v 1.3 2007/07/11 02:56:48 mr_bones_ Exp $

inherit selinux-policy

TEFILES="courier-imap.te"
FCFILES="courier-imap.fc"
IUSE=""

DESCRIPTION="SELinux policy for courier-imap"

KEYWORDS="x86 ppc sparc amd64"
