# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/mecab-perl/mecab-perl-0.97.ebuild,v 1.2 2008/11/28 21:38:41 maekke Exp $

inherit perl-module

IUSE=""

DESCRIPTION="Perl binding for MeCab"
HOMEPAGE="http://mecab.sourceforge.net/"
SRC_URI="mirror://sourceforge/mecab/${P}.tar.gz"

LICENSE="|| ( BSD LGPL-2.1 GPL-2 )"
KEYWORDS="amd64 ~ia64 x86"
SLOT="0"

DEPEND=">=app-text/mecab-${PV}
	dev-lang/perl"

src_install() {

	perl-module_src_install || die
	dohtml bindings.html || die
	dodoc test.pl || die

}
