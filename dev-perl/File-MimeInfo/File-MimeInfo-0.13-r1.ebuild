# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-MimeInfo/File-MimeInfo-0.13-r1.ebuild,v 1.5 2006/10/21 14:10:19 dertobi123 Exp $

inherit perl-module

DESCRIPTION="Determine file type"
SRC_URI="mirror://cpan/authors/id/P/PA/PARDUS/${PN}/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/CPAN/authors/id/P/PA/PARDUS/${PN}/${P}.readme"
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="amd64 ia64 ppc ~ppc64 sparc ~x86"
IUSE=""
SRC_TEST="do"
PATCHES="${FILESDIR}/mimeinfo.patch
		${FILESDIR}/test01.patch"

DEPEND="dev-perl/File-BaseDir
	x11-misc/shared-mime-info
	dev-lang/perl"
RDEPEND="${DEPEND}"

