# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/swatch/swatch-3.0.4.ebuild,v 1.7 2004/03/12 10:45:39 mr_bones_ Exp $

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
	>=dev-perl/Time-HiRes-1.12"
