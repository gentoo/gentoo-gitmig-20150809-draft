# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/RPM/RPM-0.40.ebuild,v 1.1 2002/09/09 21:53:26 mcummings Exp $

inherit perl-module

MY_P=Perl-${P}
S=${WORKDIR}/${MY_P}
DESCRIPTION="RPM:: module for perl"
SRC_URI="http://www.cpan.org/authors/id/RJRAY/${MY_P}.tar.gz"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ppc sparc sparc64"

DEPEND="${DEPEND} app-arch/rpm"

export OPTIMIZE="${CFLAGS}"
mydoc="ToDo"
