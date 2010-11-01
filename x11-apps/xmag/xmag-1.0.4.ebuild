# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xmag/xmag-1.0.4.ebuild,v 1.1 2010/11/01 15:27:04 scarabeus Exp $

EAPI=3

inherit xorg-2

DESCRIPTION="X.Org xmag application"

KEYWORDS="~amd64 ~arm ~hppa ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

RDEPEND="x11-libs/libXaw
	x11-libs/libXmu
	x11-libs/libXt
	x11-libs/libX11"
DEPEND="${RDEPEND}"
