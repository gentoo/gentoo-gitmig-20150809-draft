# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-distcc/selinux-distcc-20030728.ebuild,v 1.2 2003/08/11 01:28:24 pebenito Exp $

TEFILES="distcc.te"
FCFILES="distcc.fc"

inherit selinux-policy

S="${WORKDIR}/policy"

DESCRIPTION="SELinux policy for distcc"

KEYWORDS="~x86"

