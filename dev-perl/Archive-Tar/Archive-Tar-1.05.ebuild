# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Archive-Tar/Archive-Tar-1.05.ebuild,v 1.2 2004/01/19 22:06:31 esammer Exp $

inherit perl-module

DESCRIPTION="A Perl module for creation and manipulation of tar files"
SRC_URI="http://www.cpan.org/modules/by-module/Archive/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Archive/${P}.readme"
IUSE=""
SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha ~arm ~hppa ~mips"

DEPEND="dev-perl/IO-Zlib
		|| ( ( dev-perl/File-Spec dev-perl/Test-Simple ) >=dev-lang/perl-5.8.0-r12 )"
