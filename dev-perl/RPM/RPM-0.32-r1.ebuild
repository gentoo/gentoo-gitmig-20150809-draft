# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/RPM/RPM-0.32-r1.ebuild,v 1.3 2002/05/21 18:14:08 danarmak Exp $


inherit perl-module

MY_P=Perl-${P}
S=${WORKDIR}/${MY_P}
DESCRIPTION="RPM:: module for perl"
SRC_URI="http://www.cpan.org/authors/id/RJRAY/${MY_P}.tar.gz"

DEPEND="${DEPEND} app-arch/rpm"
LICENSE="Artistic | GPL-2"
SLOT="0"

export OPTIMIZE="${CFLAGS}"
mydoc="ToDo"
