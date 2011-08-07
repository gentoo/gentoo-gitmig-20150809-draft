# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/yard/yard-0.7.2.ebuild,v 1.2 2011/08/07 14:10:53 armin76 Exp $

EAPI=2

USE_RUBY="ruby18 ree18 ruby19 jruby"

RUBY_FAKEGEM_TASK_TEST="specs"
RUBY_FAKEGEM_TASK_DOC="yard"

RUBY_FAKEGEM_EXTRADOC="README.md ChangeLog"
RUBY_FAKEGEM_DOCDIR="doc"

RUBY_FAKEGEM_EXTRAINSTALL="templates"

inherit ruby-fakegem

DESCRIPTION="Documentation generation tool for the Ruby programming language"
HOMEPAGE="http://yardoc.org/"

LICENSE="as-is" # truly
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

ruby_add_bdepend "doc? ( || ( dev-ruby/bluecloth dev-ruby/maruku dev-ruby/rdiscount dev-ruby/kramdown ) )"
ruby_add_bdepend "test? ( dev-ruby/rspec:2 )"

each_ruby_prepare() {
	case ${RUBY} in
		*jruby)
			# Work around what appears to be a rubygems incompatibility where
			# requireing rubygems triggers expectations set by rspec. Not
			# reported upstream yet.
			rm spec/cli/diff_spec.rb || die

			# This spec requires rdiscount which is a C extension.
			sed -i -e '131s/should/should_not/' spec/templates/helpers/html_helper_spec.rb || die
			;;
		*)
			;;
	esac
}
