# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry Alexandratos <jerry@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Convert-BER/Convert-BER-1.31-r2.ebuild,v 1.1 2002/05/05 14:08:57 seemant Exp $

# Inherit the perl-module.eclass functions
. /usr/portage/eclass/inherit.eclass || die
inherit perl-module

S=${WORKDIR}/${P}
CATEGORY="dev-perl"
DESCRIPTION="A Convert Perl Module"
SRC_URI="http://www.cpan.org/modules/by-module/Convert/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Convert/${P}.readme"
