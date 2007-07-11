# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-privoxy/selinux-privoxy-20030811.ebuild,v 1.6 2007/07/11 02:56:48 mr_bones_ Exp $

TEFILES="privoxy.te"
FCFILES="privoxy.fc"
IUSE=""

inherit selinux-policy

DESCRIPTION="SELinux policy for privoxy"

KEYWORDS="x86 ppc sparc amd64"
