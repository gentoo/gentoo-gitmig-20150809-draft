# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Sys-MemInfo/Sys-MemInfo-0.91.ebuild,v 1.1 2009/12/04 10:57:31 hollow Exp $

inherit perl-module

DESCRIPTION="Memory informations"
HOMEPAGE="http://search.cpan.org/search?query=Sys-MemInfo&mode=dist"
SRC_URI="mirror://cpan/authors/id/S/SC/SCRESTO/Sys-MemInfo-0.91.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}"/${PN}
