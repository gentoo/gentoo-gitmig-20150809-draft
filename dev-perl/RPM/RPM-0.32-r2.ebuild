# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/RPM/RPM-0.32-r2.ebuild,v 1.5 2003/06/21 21:36:36 drobbins Exp $

inherit perl-module

MY_P=Perl-${P}
S=${WORKDIR}/${MY_P}
DESCRIPTION="RPM:: module for perl"
SRC_URI="http://www.cpan.org/authors/id/RJRAY/${MY_P}.tar.gz"
HOMEPAGE="http://search.cpan.org/author/RJRAY/Perl-RPM-${PV}/"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 amd64 ppc sparc alpha"

DEPEND="${DEPEND} app-arch/rpm"

export OPTIMIZE="${CFLAGS}"
mydoc="ToDo"
