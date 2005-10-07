# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/splat/splat-0.08.ebuild,v 1.17 2005/10/07 22:59:50 blubb Exp $

DESCRIPTION="Simple Portage Log Analyzer Tool"
HOMEPAGE="http://www.l8nite.net/projects/splat/"
SRC_URI="http://www.l8nite.net/projects/splat/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ~mips ppc ppc-macos ppc64 ~sparc x86"
IUSE=""

DEPEND="dev-lang/perl"

src_install() {
	newbin splat.pl splat || die
	dodoc COPYING ChangeLog
}
