# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Memoize/Memoize-1.01.ebuild,v 1.4 2004/02/20 22:31:46 vapier Exp $

inherit perl-module

MY_P=Memoize-${PV}
DESCRIPTION="Generic Perl function result caching system"
HOMEPAGE="http://perl.plover.com/Memoize/"
SRC_URI="http://www.cpan.org/modules/by-module/Memoize/${MY_P}.tar.gz"

LICENSE="Artistic GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc sparc ~alpha hppa amd64"

S=${WORKDIR}/${MY_P}
