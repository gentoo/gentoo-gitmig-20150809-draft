# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/splat/splat-0.06.ebuild,v 1.1 2003/07/17 23:08:49 vapier Exp $

DESCRIPTION="Simple Portage Log Analyzer Tool"
SRC_URI="http://www.l8nite.net/projects/splat/${P}.tar.bz2"
HOMEPAGE="http://www.l8nite.net/projects/splat/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

src_install() {
	newbin splat.pl splat
	dodoc COPYING ChangeLog
}
