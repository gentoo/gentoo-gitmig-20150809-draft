# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/patron/patron-0.4.9-r1.ebuild,v 1.2 2010/10/22 14:57:15 fauli Exp $

EAPI=2
USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_TEST="spec"
RUBY_FAKEGEM_EXTRADOC="README.txt"

RUBY_FAKEGEM_EXTRAINSTALL="VERSION.yml"

inherit multilib ruby-fakegem

DESCRIPTION="Patron is a Ruby HTTP client library based on libcurl."
HOMEPAGE="http://toland.github.com/patron/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_bdepend "doc? ( dev-ruby/jeweler )"
#ruby_add_bdepend "test? ( dev-ruby/jeweler dev-ruby/rspec )"

DEPEND="${DEPEND} net-misc/curl"
RDEPEND="${RDEPEND} net-misc/curl"

# Tests require a live web service that is not included in the distribution.
RESTRICT="test"

each_ruby_configure() {
	${RUBY} -Cext/patron extconf.rb || die
}

each_ruby_compile() {
	emake -Cext/patron || die
	cp ext/patron/session_ext$(get_modname) lib/patron/ || die "Unable to cp shared object file"
}
