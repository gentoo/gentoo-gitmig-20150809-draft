# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/splat/splat-0.06.ebuild,v 1.3 2003/10/19 09:28:12 mholzer Exp $

DESCRIPTION="Simple Portage Log Analyzer Tool"
SRC_URI="http://www.l8nite.net/projects/splat/${P}.tar.bz2"
HOMEPAGE="http://www.l8nite.net/projects/splat/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
DEPEND="dev-lang/perl"

src_install() {
	newbin splat.pl splat
	dodoc COPYING ChangeLog
}
