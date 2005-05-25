# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Memoize/Memoize-1.01.ebuild,v 1.1 2005/05/25 14:29:41 mcummings Exp $

inherit perl-module

MY_P=Memoize-${PV}
DESCRIPTION="Generic Perl function result caching system"
HOMEPAGE="http://perl.plover.com/Memoize/"
SRC_URI="mirror://cpan/authors/id/M/MJ/MJD/${P}.tar.gz"

LICENSE="Artistic GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa amd64"
IUSE=""

S=${WORKDIR}/${MY_P}
