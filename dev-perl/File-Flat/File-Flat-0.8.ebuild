# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-Flat/File-Flat-0.8.ebuild,v 1.6 2004/07/14 17:31:37 agriffis Exp $

inherit perl-module

DESCRIPTION="Implements a flat filesystem"
SRC_URI="http://www.cpan.org/modules/by-authors/id/A/AD/ADAMK/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/A/AD/ADAMK/${P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 amd64 alpha ~hppa ~mips ~ppc ~sparc"
IUSE=""

DEPEND="dev-perl/Class-Autouse
	dev-perl/File-Spec
	dev-perl/Class-Inspector"
