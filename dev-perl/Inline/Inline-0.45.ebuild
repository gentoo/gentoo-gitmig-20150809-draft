# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Inline/Inline-0.45.ebuild,v 1.1 2008/12/08 03:21:22 robbat2 Exp $

MODULE_AUTHOR=SISYPHUS
inherit perl-module eutils

DESCRIPTION="Write Perl subroutines in other languages"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="gtk"

DEPEND="virtual/perl-Digest-MD5
	virtual/perl-File-Spec
	dev-perl/Parse-RecDescent
	virtual/perl-Test-Harness
	dev-lang/perl"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
	#gtk-2 suggested patch
	use gtk && epatch ${FILESDIR}/gtk2-patch.diff
}

src_compile() {
	echo "y" | perl-module_src_compile
	perl-module_src_test
}

src_install() {
	perl-module_src_install
	dohtml DT.html
}
