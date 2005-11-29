# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-jabber-server/selinux-jabber-server-20050219.ebuild,v 1.1 2005/11/29 11:54:26 kaiowas Exp $

inherit selinux-policy

TEFILES="jabberd.te"
FCFILES="jabberd.fc"
IUSE=""

DESCRIPTION="SELinux policy for the jabber server"

KEYWORDS="~amd64 ~mips ~ppc ~sparc ~x86"

