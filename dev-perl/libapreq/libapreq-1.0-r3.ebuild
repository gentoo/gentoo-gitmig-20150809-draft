# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/libapreq/libapreq-1.0-r3.ebuild,v 1.9 2005/05/09 10:32:09 beu Exp $

inherit perl-module

DESCRIPTION="A Apache Request Perl Module"
SRC_URI="mirror://cpan/authors/id/J/JI/JIMW/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~jimw/${P}/"

SLOT="0"
LICENSE="Apache-1.1 as-is"
KEYWORDS="x86 amd64 ppc sparc alpha"
IUSE=""

DEPEND="${DEPEND}
	>=sys-apps/sed-4
	<www-apache/mod_perl-1.99"

mydoc="TODO"
