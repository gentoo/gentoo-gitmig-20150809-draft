# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/mecab-perl/mecab-perl-0.92.ebuild,v 1.7 2007/09/09 14:10:26 hattya Exp $

inherit perl-module

IUSE=""

DESCRIPTION="Perl binding for MeCab"
HOMEPAGE="http://mecab.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN/-*}/${P}.tar.gz"

LICENSE="|| ( BSD LGPL-2.1 GPL-2 )"
KEYWORDS="amd64 x86"
SLOT="0"

DEPEND=">=app-text/mecab-${PV}
	dev-lang/perl"

src_install() {

	perl-module_src_install || die
	dohtml bindings.html || die
	dodoc test.pl || die

}
