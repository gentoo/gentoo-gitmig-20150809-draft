# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry Alexandratos <jerry@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Error/Error-0.15-r1.ebuild,v 1.1 2002/05/05 16:02:27 seemant Exp $

# Inherit from perl-module.eclass
. /usr/portage/eclass/inherit.eclass || die
inherit perl-module

S=${WORKDIR}/${P}
CATEGORY="dev-perl"
DESCRIPTION="A Error Perl Module"
SRC_URI="http://www.cpan.org/modules/by-module/Error/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Error/${P}.readme"
