# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Date-Calc/Date-Calc-5.0-r2.ebuild,v 1.2 2002/05/21 18:14:07 danarmak Exp $

# Inherit the perl-module.eclass

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Date::Calc module for perl"
SRC_URI="http://www.cpan.org/authors/id/STBEY/${P}.tar.gz"

LICENSE="Artistic | GPL-2"
SLOT="0"

export OPTIMIZE="$CFLAGS"
mydoc="ToDo"
