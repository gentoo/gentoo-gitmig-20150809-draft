# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/RPM/RPM-0.32-r1.ebuild,v 1.5 2002/07/25 04:43:33 seemant Exp $

inherit perl-module

MY_P=Perl-${P}
S=${WORKDIR}/${MY_P}
DESCRIPTION="RPM:: module for perl"
SRC_URI="http://www.cpan.org/authors/id/RJRAY/${MY_P}.tar.gz"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86"

DEPEND="${DEPEND} app-arch/rpm"

export OPTIMIZE="${CFLAGS}"
mydoc="ToDo"
