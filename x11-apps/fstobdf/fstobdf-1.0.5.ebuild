# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/fstobdf/fstobdf-1.0.5.ebuild,v 1.4 2012/06/27 18:00:02 maekke Exp $

EAPI=4

inherit xorg-2

DESCRIPTION="generate BDF font from X font server"
KEYWORDS="amd64 arm ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libFS"
DEPEND="${RDEPEND}"
