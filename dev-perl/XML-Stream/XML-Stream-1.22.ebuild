# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Stream/XML-Stream-1.22.ebuild,v 1.6 2005/03/30 22:34:32 gustavoz Exp $

inherit perl-module

DESCRIPTION="Creates and XML Stream connection and parses return data"
SRC_URI="mirror://cpan/authors/id/R/RE/REATMON/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~reatmon/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ~ppc sparc alpha"
IUSE="ssl"

SRC_TEST="do"

DEPEND="dev-perl/Authen-SASL
	dev-perl/Net-DNS
	ssl? ( dev-perl/IO-Socket-SSL )
	dev-perl/MIME-Base64"
