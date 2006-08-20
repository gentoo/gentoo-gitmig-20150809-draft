# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Alien-wxWidgets/Alien-wxWidgets-0.20.ebuild,v 1.1 2006/08/20 02:34:09 mcummings Exp $

inherit perl-module

MY_P=Alien-wxWidgets-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Building, finding and using wxWidgets binaries"
SRC_URI="mirror://cpan/authors/id/M/MB/MBARBON/${MY_P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~mbarbon/${P}/"
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-lang/perl
	x11-libs/wxGTK
	>=dev-perl/module-build-0.26
	>=dev-perl/Module-Pluggable-3.1-r1"

perl-module_src_prep() {
	perlinfo
	echo no | perl Build.PL --installdirs=vendor \
		   	    --destdir=${D} \
			    --libdoc= || die "perl Build.PL has failed!"
}
