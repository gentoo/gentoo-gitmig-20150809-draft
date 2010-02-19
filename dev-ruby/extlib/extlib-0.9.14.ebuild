# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/extlib/extlib-0.9.14.ebuild,v 1.1 2010/02/19 12:51:08 graaff Exp $

EAPI="2"
USE_RUBY="ruby18"

# Depends on jeweler which we don't have yet.
RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README.rdoc"
RUBY_FAKEGEM_TASK_TEST="-f tasks/spec.rake spec"

inherit ruby-fakegem

DESCRIPTION="Support library for DataMapper and Merb"
HOMEPAGE="http://extlib.rubyforge.org"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

ruby_add_bdepend test ">=dev-ruby/json-1.2.0
	>=dev-ruby/rspec-1.2.9"

each_ruby_prepare() {
	sed -i '/check_dependencies/d' tasks/spec.rake || die "Unable to remove check_dependencies rules."
}
