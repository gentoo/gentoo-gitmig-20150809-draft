# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTTP-DAV/HTTP-DAV-0.31.ebuild,v 1.6 2005/05/09 18:19:08 gustavoz Exp $

inherit perl-module

DESCRIPTION="A WebDAV client library for Perl5"
HOMEPAGE="http://search.cpan.org/~pcollins/${P}/"
SRC_URI="mirror://cpan/authors/id/P/PC/PCOLLINS/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/libwww-perl
		dev-perl/XML-DOM"
