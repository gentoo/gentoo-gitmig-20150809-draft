# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-MimeInfo/File-MimeInfo-0.10.ebuild,v 1.1 2004/02/15 02:54:32 esammer Exp $

inherit perl-module

DESCRIPTION="The Perl File-MimeInfo Module"
SRC_URI="http://search.cpan.org/CPAN/authors/id/P/PA/PARDUS/${PN}/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/CPAN/authors/id/P/PA/PARDUS/${PN}/${P}.readme"
SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-perl/File-BaseDir
	x11-misc/shared-mime-info"
