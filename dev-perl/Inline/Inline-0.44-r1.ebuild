# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Inline/Inline-0.44-r1.ebuild,v 1.14 2005/03/13 03:32:15 vapier Exp $

inherit perl-module eutils

DESCRIPTION="Write Perl subroutines in other languages"
HOMEPAGE="http://search.cpan.org/doc/INGY/Inline-0.43/Inline.pod"
SRC_URI="http://www.cpan.org/authors/id/I/IN/INGY/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc sparc x86"
IUSE="gtk2"

DEPEND="dev-perl/Digest-MD5
	dev-perl/File-Spec
	dev-perl/Parse-RecDescent
	dev-perl/Test-Harness"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
	#gtk-2 suggested patch
	use gtk2 && epatch ${FILESDIR}/gtk2-patch.diff
}

src_compile() {
	echo "y" | perl-module_src_compile
	perl-module_src_test
}

src_install() {
	perl-module_src_install
	dohtml DT.html
}
