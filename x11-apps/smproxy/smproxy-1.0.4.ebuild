# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/smproxy/smproxy-1.0.4.ebuild,v 1.6 2010/12/25 19:55:23 fauli Exp $

EAPI=3

inherit xorg-2

DESCRIPTION="Session Manager Proxy"

KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ~ppc ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="x11-libs/libSM
	x11-libs/libXt
	x11-libs/libXmu"
DEPEND="${RDEPEND}"
