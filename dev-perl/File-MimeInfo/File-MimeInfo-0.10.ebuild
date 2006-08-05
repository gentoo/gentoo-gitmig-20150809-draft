# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-MimeInfo/File-MimeInfo-0.10.ebuild,v 1.12 2006/08/05 03:42:43 mcummings Exp $

inherit perl-module

DESCRIPTION="Determine file type"
SRC_URI="mirror://cpan/authors/id/P/PA/PARDUS/${PN}/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/CPAN/authors/id/P/PA/PARDUS/${PN}/${P}.readme"
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 sparc ppc ~ppc64"
IUSE=""
SRC_TEST="do"

DEPEND="dev-perl/File-BaseDir
	x11-misc/shared-mime-info
	dev-lang/perl"
RDEPEND="${DEPEND}"


