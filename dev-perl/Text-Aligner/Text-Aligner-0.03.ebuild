# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-Aligner/Text-Aligner-0.03.ebuild,v 1.1 2010/07/15 08:00:59 dev-zero Exp $

EAPI="3"

MODULE_AUTHOR="ANNO"

inherit perl-module

DESCRIPTION="Used to justify strings to various alignment styles"
HOMEPAGE="http://search.cpan.org/~anno/Text-Aligner"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

SRC_TEST="do"

COMMON="dev-lang/perl"
DEPEND="${COMMON}"
RDEPEND="${COMMON}"

src_install() {
	mydoc="Changes README"
	perl-module_src_install
}
