# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry Alexandratos <jerry@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Error/Error-0.15-r1.ebuild,v 1.2 2002/05/21 18:14:07 danarmak Exp $

# Inherit from perl-module.eclass

inherit perl-module

S=${WORKDIR}/${P}
CATEGORY="dev-perl"
DESCRIPTION="A Error Perl Module"
SRC_URI="http://www.cpan.org/modules/by-module/Error/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Error/${P}.readme"
