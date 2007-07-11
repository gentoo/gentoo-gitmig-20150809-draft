# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-audio-entropyd/selinux-audio-entropyd-20050210.ebuild,v 1.3 2007/07/11 02:56:48 mr_bones_ Exp $

inherit selinux-policy

TEFILES="audio-entropyd.te"
FCFILES="audio-entropyd.fc"
IUSE=""

DESCRIPTION="SELinux policy for audio-entropyd"

KEYWORDS="x86 ppc sparc amd64"
