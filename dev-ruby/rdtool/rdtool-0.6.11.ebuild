# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rdtool/rdtool-0.6.11.ebuild,v 1.4 2003/09/07 03:11:16 agriffis Exp $

DESCRIPTION="A multipurpose documentation format for Ruby"
SRC_URI="http://www2.pos.to/~tosh/ruby/rdtool/archive/${P}.tar.gz"
HOMEPAGE="http://www2.pos.to/~tosh/ruby/rdtool/en/index.html"
LICENSE="Ruby"
KEYWORDS="~x86"
SLOT="0"

DEPEND=">=dev-lang/ruby-1.8.0
	>=dev-ruby/racc-1.3"
	# These are part of ruby as of 1.8.0 (06 Sep 2003 agriffis)
	# >=dev-ruby/optparse-0.7.5
	# >=dev-ruby/strscan-0.5.8

src_compile() {
	ruby rdtoolconf.rb || die
	make || die
}

src_install () {
	chmod 755 rd2
	dobin rd2

	cd ${S}/rd
	insinto /usr/lib/ruby/site_ruby/1.8/rd
	doins dot.rd2rc *.rb
}
