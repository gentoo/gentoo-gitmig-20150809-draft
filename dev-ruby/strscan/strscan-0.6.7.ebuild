# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/strscan/strscan-0.6.7.ebuild,v 1.3 2003/12/29 14:27:23 usata Exp $

inherit ruby

IUSE=""

DESCRIPTION="A library for fast scanning"
HOMEPAGE="http://i.loveruby.net/en/strscan.html"
SRC_URI="http://i.loveruby.net/archive/strscan/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha arm hppa mips ppc sparc x86"

USE_RUBY="ruby16"
DEPEND="=dev-lang/ruby-1.6*"

src_install() {

	einstall || die

	dodoc README*
	docinto doc.en
	dodoc doc.en/ChangeLog doc.en/umanual.rd
	dohtml doc.en/umanual.html

	docinto doc.ja
	dodoc doc.ja/ChangeLog doc.ja/umanual.rd
	dohtml doc.ja/umanual.html
}
