# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/yard/yard-0.7.4.ebuild,v 1.1 2011/12/07 10:36:35 graaff Exp $

EAPI=2

USE_RUBY="ruby18 ree18 jruby"

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

all_ruby_prepare() {
	# jruby crashes on this version of metadata, so install our stub.
	rm ../metadata || die
}

each_ruby_prepare() {
	case ${RUBY} in
		*jruby)
			# This spec requires rdiscount which is a C extension.
			sed -i -e '145s/should/should_not/' spec/templates/helpers/html_helper_spec.rb || die
			;;
		*)
			;;
	esac
}
