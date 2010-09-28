# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/i18n/i18n-0.1.3.ebuild,v 1.9 2010/09/28 20:03:56 ranger Exp $

EAPI=2

USE_RUBY="ruby18 ree18 jruby"

RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_EXTRADOC="README.textile"

inherit ruby-fakegem versionator

DESCRIPTION="Add Internationalization support to your Ruby application."
HOMEPAGE="http://rails-i18n.org/"

# We have a valid expectance that *this* is the correct tarball for
# version 0.1.3, unfortunately there is *no such official release* as
# the one bundled with activesupport. On the other hand, this seems to
# be it, minus some test changes.
SRC_URI="http://github.com/svenfuchs/i18n/tarball/38d85ea3b8eec032c1b0898a30f8010917416d9d -> ${PN}-git-${PV}.tgz"
S="${WORKDIR}/svenfuchs-${PN}-38d85ea"

LICENSE="MIT"
SLOT="$(get_version_component_range 1-2)"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86 ~ppc-macos ~x64-solaris ~x86-solaris"
IUSE=""

ruby_add_bdepend test "dev-ruby/mocha dev-ruby/activesupport"

src_prepare() {
	ruby-ng_src_prepare
	chmod 0755 "${HOME}" || die "Failed to fix permissions on home"
}

src_test() {
	chmod 0755 "${HOME}" || die "Failed to fix permissions on home"
	ruby-ng_src_test
}
