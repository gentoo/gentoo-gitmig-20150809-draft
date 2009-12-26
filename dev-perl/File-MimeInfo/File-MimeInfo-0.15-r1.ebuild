# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-MimeInfo/File-MimeInfo-0.15-r1.ebuild,v 1.3 2009/12/26 19:01:06 armin76 Exp $

MODULE_AUTHOR=PARDUS
inherit perl-module

DESCRIPTION="Determine file type"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86"
IUSE=""
SRC_TEST="do"

RDEPEND=">=dev-perl/File-BaseDir-0.03
	>=dev-perl/File-DesktopEntry-0.04
	x11-misc/shared-mime-info
	dev-lang/perl"
DEPEND="virtual/perl-Module-Build
	${RDEPEND}"
