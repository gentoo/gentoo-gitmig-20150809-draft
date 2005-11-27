# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MP3-Tag/MP3-Tag-0.94.ebuild,v 1.8 2005/11/27 22:23:56 tgall Exp $

IUSE=""

inherit perl-module

S=${WORKDIR}/MP3-Tag-0.94

DESCRIPTION="Tag - Module for reading tags of mp3 files"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/I/IL/ILYAZ/modules/${P}.readme"
SRC_URI="mirror://cpan/modules/by-authors/id/I/IL/ILYAZ/modules/${P}.tar.gz"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="amd64 ppc ppc64 sparc x86"
