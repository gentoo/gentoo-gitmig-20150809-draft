# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-ucspi-tcp/selinux-ucspi-tcp-20041016.ebuild,v 1.1 2004/10/23 09:44:18 kaiowas Exp $

inherit selinux-policy

TEFILES="ucspi-tcp.te"
FCFILES="ucspi-tcp.fc"
IUSE=""

DESCRIPTION="SELinux policy for ucspi-tcp"

KEYWORDS="~x86 ~ppc ~sparc ~amd64"

