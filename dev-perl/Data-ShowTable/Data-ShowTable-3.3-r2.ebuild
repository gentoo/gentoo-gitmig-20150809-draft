# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Data-ShowTable/Data-ShowTable-3.3-r2.ebuild,v 1.14 2008/08/26 13:34:24 tove Exp $

MODULE_AUTHOR=AKSTE
inherit perl-module

DESCRIPTION="routines to display tabular data in several formats"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE=""

DEPEND="dev-lang/perl"
PATCHES="${FILESDIR}/${PV}-perlpath.patch"

src_install () {
	perl-module_src_install
	dohtml *.html
}
