# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/RPM/RPM-0.40-r1.ebuild,v 1.10 2005/04/28 19:04:58 mcummings Exp $

inherit perl-module

MY_P=Perl-${P}
S=${WORKDIR}/${MY_P}
DESCRIPTION="RPM:: module for perl"
SRC_URI="mirror://cpan/authors/id/RJRAY/${MY_P}.tar.gz"
HOMEPAGE="http://search.cpan.org/author/RJRAY/Perl-RPM-${PV}/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 amd64 ppc sparc alpha"
IUSE=""

DEPEND="${DEPEND} =app-arch/rpm-4.0.4-r5"

export OPTIMIZE="${CFLAGS}"
mydoc="ToDo"
