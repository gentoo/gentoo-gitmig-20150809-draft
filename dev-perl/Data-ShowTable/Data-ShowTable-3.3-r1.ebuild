# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Data-ShowTable/Data-ShowTable-3.3-r1.ebuild,v 1.2 2002/05/21 18:14:07 danarmak Exp $

# Inherit from perl-module.eclass functions

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="The Perl ShowTable Module"
SRC_URI="http://www.cpan.org/modules/by-module/Data/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Data/${P}.readme"
LICENSE="GPL-2"
SLOT="0"

mydoc="Copyright GNU-LICENSE"

src_install () {

	base_src_install
	dohtml *.html
}
