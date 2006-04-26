# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-MimeInfo/File-MimeInfo-0.13.ebuild,v 1.1 2006/04/26 00:12:15 mcummings Exp $

inherit perl-module

DESCRIPTION="Determine file type"
SRC_URI="mirror://cpan/authors/id/P/PA/PARDUS/${PN}/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/CPAN/authors/id/P/PA/PARDUS/${PN}/${P}.readme"
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""
SRC_TEST="do"

DEPEND="dev-perl/File-BaseDir
	x11-misc/shared-mime-info"
