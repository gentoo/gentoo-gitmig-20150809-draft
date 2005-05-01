# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-IRC/Net-IRC-0.75.ebuild,v 1.7 2005/05/01 18:10:38 slarti Exp $

inherit perl-module

DESCRIPTION="Perl IRC module"
SRC_URI="mirror://cpan/authors/id/J/JM/JMUHLICH/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/search?module=Net::IRC"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ppc sparc alpha"
IUSE=""

SRC_TEST="do"

mydoc="TODO"
