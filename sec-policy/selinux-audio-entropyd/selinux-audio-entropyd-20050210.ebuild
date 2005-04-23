# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-audio-entropyd/selinux-audio-entropyd-20050210.ebuild,v 1.1 2005/04/23 17:01:46 kaiowas Exp $

inherit selinux-policy

TEFILES="audio-entropyd.te"
FCFILES="audio-entropyd.fc"
IUSE=""

DESCRIPTION="SELinux policy for audio-entropyd"

KEYWORDS="~x86 ~ppc ~sparc ~amd64"

