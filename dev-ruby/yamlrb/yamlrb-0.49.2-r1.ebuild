# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/yamlrb/yamlrb-0.49.2-r1.ebuild,v 1.1 2003/04/11 08:30:47 twp Exp $

DESCRIPTION="Machine parsable data serialization format designed for human readability"
HOMEPAGE="http://yaml4r.sourceforge.net/"
SRC_URI="mirror://sourceforge/yaml4r/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
DEPEND=">=dev-lang/ruby-1.6.0"

src_install() {
	local sitelibdir=`ruby -r rbconfig -e 'print(Config::CONFIG["sitelibdir"])'`
	insinto ${sitelibdir}
	doins src/okay.rb src/yaml.rb src/yod.rb
	insinto ${sitelibdir}/okay
	doins src/okay/news.rb src/okay/rpc.rb
	dodoc README CHANGELOG
}
