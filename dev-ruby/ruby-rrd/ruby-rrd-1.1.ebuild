# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-rrd/ruby-rrd-1.1.ebuild,v 1.3 2006/06/02 13:07:15 flameeyes Exp $

inherit ruby

IUSE=""
USE_RUBY="ruby18"

DESCRIPTION="Simple RRDTool wrapper for Ruby"
HOMEPAGE="http://people.ee.ethz.ch/~oetiker/webtools/rrdtool/"
SRC_URI="http://people.ee.ethz.ch/~oetiker/webtools/rrdtool/pub/contrib/${P}.tar.gz"

KEYWORDS="~amd64 x86"
LICENSE="Ruby"
SLOT="0"

DEPEND="virtual/ruby
		>=net-analyzer/rrdtool-1.0.47"

src_unpack() {
	ruby_src_unpack

	has_version '>=net-analyzer/rrdtool-1.2' && \
		epatch "${FILESDIR}/${PN}-rrdtool-1.2.patch"
}

src_compile() {
	ruby extconf.rb || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc README test.rb
}
