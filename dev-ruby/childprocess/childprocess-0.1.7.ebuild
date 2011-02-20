# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/childprocess/childprocess-0.1.7.ebuild,v 1.1 2011/02/20 08:18:13 graaff Exp $

EAPI=2
USE_RUBY="ruby18 ree18"

RUBY_FAKEGEM_TASK_TEST="spec"

RUBY_FAKEGEM_TASK_DOC="yard"
RUBY_FAKEGEM_EXTRADOC="README.rdoc"

inherit ruby-fakegem

DESCRIPTION="A simple and reliable solution for controlling external programs running in the background."
HOMEPAGE="https://github.com/jarib/childprocess"

LICENSE="MIT"
SLOT="2"
KEYWORDS="~amd64"
IUSE=""

ruby_add_bdepend "
	doc? ( dev-ruby/yard )
	test? ( dev-ruby/rspec:2 )"

ruby_add_rdepend "virtual/ruby-ffi"

all_ruby_prepare() {
	# Avoid hard dependency on jeweler.
	sed -i -e '/check_dependencies/d' Rakefile || die
}
