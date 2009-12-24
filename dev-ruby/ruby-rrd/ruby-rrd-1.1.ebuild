# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-rrd/ruby-rrd-1.1.ebuild,v 1.5 2009/12/24 17:07:59 graaff Exp $

inherit ruby

IUSE=""
USE_RUBY="ruby18"

DESCRIPTION="Simple RRDTool wrapper for Ruby"
HOMEPAGE="http://people.ee.ethz.ch/~oetiker/webtools/rrdtool/"
SRC_URI="http://people.ee.ethz.ch/~oetiker/webtools/rrdtool/pub/contrib/${P}.tar.gz"

KEYWORDS="~amd64 ~sparc x86"
LICENSE="Ruby"
SLOT="0"

DEPEND=">=net-analyzer/rrdtool-1.0.47"
RDEPEND="${DEPEND}"

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
