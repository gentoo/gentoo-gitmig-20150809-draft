# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Archive-Tar/Archive-Tar-1.10.ebuild,v 1.3 2004/11/20 04:44:33 dragonheart Exp $

inherit perl-module

DESCRIPTION="A Perl module for creation and manipulation of tar files"
HOMEPAGE="http://www.cpan.org/modules/by-module/Archive/${P}.readme"
SRC_URI="http://www.cpan.org/modules/by-module/Archive/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~mips ppc ~sparc ~x86"
IUSE=""

DEPEND="dev-perl/IO-Zlib
	|| ( ( dev-perl/File-Spec dev-perl/Test-Simple ) >=dev-lang/perl-5.8.0-r12 )"
