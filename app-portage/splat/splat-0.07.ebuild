# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/splat/splat-0.07.ebuild,v 1.9 2005/01/01 15:55:37 eradicator Exp $

DESCRIPTION="Simple Portage Log Analyzer Tool"
HOMEPAGE="http://www.l8nite.net/projects/splat/"
SRC_URI="http://www.l8nite.net/projects/splat/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ppc x86"
IUSE=""

DEPEND="dev-lang/perl"

src_install() {
	newbin splat.pl splat || die
	dodoc COPYING ChangeLog
}
