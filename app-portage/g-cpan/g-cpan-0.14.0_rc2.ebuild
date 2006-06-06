# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/g-cpan/g-cpan-0.14.0_rc2.ebuild,v 1.1 2006/06/06 22:02:37 mcummings Exp $

inherit perl-module

DESCRIPTION="g-cpan: generate and install CPAN modules using portage"
HOMEPAGE="http://www.gentoo.org/proj/en/perl/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc-macos ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

DEPEND="dev-lang/perl
		dev-perl/yaml"

src_install() {
		perl-module_src_install
		dodir /var/tmp/g-cpan
}

