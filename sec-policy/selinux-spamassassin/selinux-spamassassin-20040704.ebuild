# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-spamassassin/selinux-spamassassin-20040704.ebuild,v 1.2 2004/09/20 01:55:47 pebenito Exp $

TEFILES="spamassassin.te spamc.te spamd.te"
FCFILES="spamassassin.fc spamc.fc spamd.fc"
MACROS="spamassassin_macros.te"
IUSE=""

inherit selinux-policy

DESCRIPTION="SELinux policy for SpamAssassin"

KEYWORDS="x86 ppc sparc amd64"

