# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MP3-Tag/MP3-Tag-0.9706.ebuild,v 1.1 2006/05/01 20:52:56 mcummings Exp $

IUSE=""

inherit perl-module eutils

DESCRIPTION="Tag - Module for reading tags of mp3 files"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/I/IL/ILYAZ/modules/${P}.readme"
SRC_URI="mirror://cpan/modules/by-authors/id/I/IL/ILYAZ/modules/${P}.tar.gz"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
SRC_TEST="do"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-makefile.patch
}
