# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/swatch/swatch-3.1.1.ebuild,v 1.2 2004/11/12 16:34:26 blubb Exp $

inherit perl-module

DESCRIPTION="Perl-based system log watcher"
HOMEPAGE="http://swatch.sourceforge.net/"
SRC_URI="mirror://sourceforge/swatch/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

DEPEND="${DEPEND}
	dev-perl/DateManip
	dev-perl/Date-Calc
	dev-perl/TimeDate
	dev-perl/File-Tail
	>=dev-perl/Time-HiRes-1.12"
