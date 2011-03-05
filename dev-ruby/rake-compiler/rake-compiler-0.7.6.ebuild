# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rake-compiler/rake-compiler-0.7.6.ebuild,v 1.2 2011/03/05 07:18:06 graaff Exp $

EAPI=2
USE_RUBY="ruby18 ree18 ruby19 jruby"

# Tests for now seem only to work when rubygems is fully installed for
# the implementation and that for now only means Ruby 1.8
RUBY_FAKEGEM_TASK_TEST="-f tasks/rspec.rake -f tasks/cucumber.rake spec cucumber"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="History.txt README.rdoc"

inherit ruby-fakegem eutils

DESCRIPTION="Provide a standard and simplified way to build and package Ruby extensions"
HOMEPAGE="http://github.com/luislavena/rake-compiler"
LICENSE="as-is" # truly

SRC_URI="http://github.com/luislavena/${PN}/tarball/v${PV} -> ${P}.tar.gz"
S="${WORKDIR}/luislavena-${PN}-*"

KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x64-solaris ~x86-solaris"
SLOT="0"
IUSE=""

USE_RUBY=ruby18 \
	ruby_add_bdepend "test? ( dev-ruby/rspec:0 dev-util/cucumber dev-ruby/rubygems )"

ruby_add_rdepend "dev-ruby/rake"

each_ruby_prepare() {
	case ${RUBY} in
		*ruby19|*jruby)
			# Remove this task so that it won't load on Ruby 1.9 and JRuby
			# that lack the package_task file. It is, though, needed for the
			# tests
			rm tasks/gem.rake || die
			;;
		*)
			;;
	esac
}

each_ruby_test() {
	case ${RUBY} in
		*ruby19|*jruby)
			ewarn "Tests disabled for this implementation. Long story, check ebuild if you want."
			;;
		*)
			each_fakegem_test
			;;
	esac
}
