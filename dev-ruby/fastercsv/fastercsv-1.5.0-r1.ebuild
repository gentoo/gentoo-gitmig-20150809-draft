# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/fastercsv/fastercsv-1.5.0-r1.ebuild,v 1.1 2010/01/13 17:07:14 flameeyes Exp $

EAPI=2

# ruby19 → not needed, it's bundled as part of the main package
# jruby → tests fail (badly?) for encoding and zlib support
USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_DOC="rdoc"

RUBY_FAKEGEM_DOCDIR="doc/html"
RUBY_FAKEGEM_EXTRADOC="AUTHORS CHANGELOG README TODO"

inherit ruby-fakegem

ruby_add_bdepend test virtual/ruby-test-unit

DESCRIPTION="FasterCSV is a replacement for the standard CSV library"
HOMEPAGE="http://fastercsv.rubyforge.org/"
LICENSE="|| ( Ruby GPL-2 )"

KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

ruby_add_rdepend test virtual/ruby-test-unit

all_ruby_install() {
	all_fakegem_install

	docinto examples
	dodoc examples/* || die
}
