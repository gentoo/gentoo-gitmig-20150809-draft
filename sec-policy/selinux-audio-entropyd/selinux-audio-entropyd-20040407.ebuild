# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-audio-entropyd/selinux-audio-entropyd-20040407.ebuild,v 1.3 2004/09/20 01:55:46 pebenito Exp $

TEFILES="audio-entropyd.te"
FCFILES="audio-entropyd.fc"
IUSE=""

inherit selinux-policy

DESCRIPTION="SELinux policy for audio-entropyd"

KEYWORDS="x86 ppc sparc amd64"

