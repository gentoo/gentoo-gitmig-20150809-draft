# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xvinfo/xvinfo-1.1.0.ebuild,v 1.3 2009/12/10 18:52:40 fauli Exp $

inherit x-modular

DESCRIPTION="Print out X-Video extension adaptor information"

KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="x11-libs/libXv
	x11-libs/libX11"
DEPEND="${RDEPEND}"
