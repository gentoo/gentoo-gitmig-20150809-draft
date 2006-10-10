# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/swatch/swatch-3.2.1.ebuild,v 1.1 2006/10/10 21:23:54 g2boojum Exp $

inherit perl-app

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
	>=virtual/perl-Time-HiRes-1.12"
