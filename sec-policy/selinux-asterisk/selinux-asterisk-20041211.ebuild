# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-asterisk/selinux-asterisk-20041211.ebuild,v 1.1 2004/12/12 11:42:35 kaiowas Exp $

inherit selinux-policy

TEFILES="asterisk.te"
FCFILES="asterisk.fc"
IUSE=""

DESCRIPTION="Gentoo SELinux policy for asterisk, a modular open-source PBX system"

KEYWORDS="~x86 ~ppc ~sparc ~amd64"

