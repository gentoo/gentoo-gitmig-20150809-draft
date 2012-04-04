# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xlsatoms/xlsatoms-1.1.1.ebuild,v 1.1 2012/04/04 12:53:26 chithanh Exp $

EAPI=4

inherit xorg-2

DESCRIPTION="list interned atoms defined on server"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="x11-libs/libxcb"
DEPEND="${RDEPEND}"
