# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/CPAN-Mini-Phalanx/CPAN-Mini-Phalanx-0.10.0.ebuild,v 1.2 2011/09/03 21:04:56 tove Exp $

EAPI=4

MY_PN=CPAN-Mini-Phalanx100
MODULE_AUTHOR=SMPETERS
MODULE_VERSION=0.01
inherit perl-module

DESCRIPTION="create a minimal mirror of CPAN containing the modules in the Phalanx 100"

SLOT="0"
KEYWORDS="~amd64 ia64 sparc x86"
IUSE="test"

RDEPEND="dev-perl/CPAN-Mini"
DEPEND="
	test? (
		${RDEPEND}
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)"

SRC_TEST="do"

src_prepare() {
	perl-module_src_prepare
	sed -i 's,^L<Phalanx Project|,L<,' "${S}"/lib/CPAN/Mini/Phalanx100.pm || die
}
