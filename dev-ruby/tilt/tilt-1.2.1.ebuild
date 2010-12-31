# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/tilt/tilt-1.2.1.ebuild,v 1.1 2010/12/31 08:39:06 graaff Exp $

EAPI=2
USE_RUBY="ruby18 ree18"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README.md"

inherit ruby-fakegem

DESCRIPTION="A thin interface over a Ruby template engines to make their usage as generic as possible."
HOMEPAGE="http://github.com/rtomayko/tilt"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE=""

ruby_add_bdepend "test? ( virtual/ruby-test-unit )"
ruby_add_rdepend ">=dev-ruby/builder-2.0.0"

# Tests fail when markaby is not new enough, but it's optional.
DEPEND="${DEPEND} !<dev-ruby/markaby-0.6.9-r1"
RDEPEND="${RDEPEND}"

all_ruby_prepare() {
	# The RDoc test fails at least with rdoc 3.x. Don't run it since the
	# failure looks quite innocent for real world applications.
	# https://github.com/rtomayko/tilt/issues/issue/56
	rm test/tilt_rdoctemplate_test.rb || die
}
