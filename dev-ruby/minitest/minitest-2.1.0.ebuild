# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/minitest/minitest-2.1.0.ebuild,v 1.1 2011/04/13 05:47:55 graaff Exp $

EAPI=2
# jruby → tests fail, reported upstream
# http://rubyforge.org/tracker/index.php?func=detail&aid=27657&group_id=1040&atid=4097
USE_RUBY="ruby18 ruby19 ree18 jruby"

RUBY_FAKEGEM_TASK_DOC="docs"

RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="History.txt Manifest.txt README.txt"

inherit ruby-fakegem

DESCRIPTION="minitest/unit is a small and fast replacement for ruby's huge and slow test/unit."
HOMEPAGE="http://rubyforge.org/projects/bfts"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE=""

ruby_add_bdepend "
	doc? ( dev-ruby/hoe )
	test? (
		virtual/ruby-test-unit
		dev-ruby/hoe
	)"

each_ruby_test() {
	case ${RUBY} in
		*jruby)
				eqawarn "Skipping tests on JRuby, bug 321055."
				;;
		*)
				each_fakegem_test
				;;
	esac
}
