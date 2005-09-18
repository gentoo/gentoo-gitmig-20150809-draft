# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-spamassassin/selinux-spamassassin-20050219.ebuild,v 1.3 2005/09/18 10:35:33 kaiowas Exp $

inherit selinux-policy

TEFILES="spamassassin.te spamc.te spamd.te"
FCFILES="spamassassin.fc spamc.fc spamd.fc"
MACROS="spamassassin_macros.te"
IUSE=""
RDEPEND=">=sec-policy/selinux-base-policy-20050224"

DESCRIPTION="SELinux policy for SpamAssassin"

KEYWORDS="amd64 mips ppc sparc x86"

