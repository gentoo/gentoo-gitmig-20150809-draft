# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/swatch/swatch-3.0.8.ebuild,v 1.7 2005/05/25 15:22:07 mcummings Exp $

inherit perl-module

DESCRIPTION="Perl-based system log watcher"
HOMEPAGE="http://swatch.sourceforge.net/"
SRC_URI="mirror://sourceforge/swatch/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

DEPEND="${DEPEND}
	dev-perl/Date-Calc
	dev-perl/TimeDate
	dev-perl/File-Tail
	>=perl-core/Time-HiRes-1.12"
