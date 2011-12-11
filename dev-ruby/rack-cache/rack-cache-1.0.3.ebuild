# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rack-cache/rack-cache-1.0.3.ebuild,v 1.4 2011/12/11 21:47:04 maekke Exp $

EAPI=4
USE_RUBY="ruby18 ree18"

# no documentation is generable, it needs hanna, which is broken
RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_TASK_TEST="none"

RUBY_FAKEGEM_EXTRADOC="CHANGES README TODO"

inherit versionator ruby-fakegem

DESCRIPTION="A drop-in component to enable HTTP caching for Rack-based applications that produce freshness info."
HOMEPAGE="http://tomayko.com/src/rack-cache/"

LICENSE="MIT"
SLOT="$(get_version_component_range 1-2)"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""

ruby_add_bdepend "test? ( dev-ruby/bacon )"

each_ruby_test() {
	${RUBY} -S bacon -q -I.:lib:test test/*_test.rb || die
}
