# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-MMagic/File-MMagic-1.22.ebuild,v 1.11 2005/07/09 23:10:42 swegener Exp $

inherit perl-module

DESCRIPTION="The Perl Image-Info Module"
SRC_URI="mirror://cpan/authors/id/K/KN/KNOK/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/File/${P}.readme"
SRC_TEST="do"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 amd64 ppc sparc alpha ppc64"
IUSE=""
