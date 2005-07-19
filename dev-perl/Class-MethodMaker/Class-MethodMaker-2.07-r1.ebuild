# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-MethodMaker/Class-MethodMaker-2.07-r1.ebuild,v 1.1 2005/07/19 11:21:39 mcummings Exp $

inherit perl-module eutils

DESCRIPTION="Perl module for Class::MethodMaker"
HOMEPAGE="http://search.cpan.org/~fluffy/${MY_P}"
SRC_URI="mirror://cpan/authors/id/F/FL/FLUFFY/${P}.tar.gz"


LICENSE="Artistic"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/module-build"

src_unpack() {
	unpack ${A}
	cd ${S}
	# Correct bad Build.PL so that libs are found correctly for building -
	# mcummings
	epatch ${FILESDIR}/C-MM-Build.patch
	# Wipe the signature file - we no longer match since we 'tampered' with the
	# Build.PL above - mcummings
	cp -f ${FILESDIR}/0-signature.t ${S}/t/0-signature.t

}
