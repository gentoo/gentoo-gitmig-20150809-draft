# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/mkfontdir/mkfontdir-1.0.5.ebuild,v 1.2 2009/12/10 12:35:42 ssuominen Exp $

inherit x-modular

DESCRIPTION="create an index of X font files in a directory"

KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="x11-apps/mkfontscale"
DEPEND="${RDEPEND}"
