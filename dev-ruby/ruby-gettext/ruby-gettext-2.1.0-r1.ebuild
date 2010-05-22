# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gettext/ruby-gettext-2.1.0-r1.ebuild,v 1.1 2010/05/22 19:49:52 flameeyes Exp $

EAPI=2

# ruby19 → tests fail badly, somebody has to look into them
USE_RUBY="ruby18 jruby ree18"

RUBY_FAKEGEM_NAME="${PN/ruby-/}"

RUBY_FAKEGEM_TASK_DOC="rerdoc"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="ChangeLog ChangeLog-1 NEWS-1 README.rdoc"

RUBY_FAKEGEM_TASK_TEST="test"

RUBY_FAKEGEM_EXTRAINSTALL="data"

inherit ruby-fakegem

DESCRIPTION="Ruby GetText Package is Native Language Support Library and Tools modeled after GNU gettext package"
HOMEPAGE="http://www.yotabanana.com/hiki/ruby-gettext.html"

KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE=""
SLOT="0"
LICENSE="Ruby"

ruby_add_rdepend ">=dev-ruby/locale-2.0.5"

RDEPEND="${RDEPEND}
	sys-devel/gettext"
DEPEND="${DEPEND}
	sys-devel/gettext"

ruby_add_bdepend "test? ( || ( virtual/ruby-test-unit dev-ruby/test-unit:2 ) )"

each_ruby_test() {
	# Upstream tries to daisy-chain rake calls but they fail badly
	# with our setup, so run it manually.
	pushd test
	${RUBY} -S rake test || die "tests failed"
	popd
}

all_ruby_install() {
	all_fakegem_install

	insinto /usr/share/doc/${PF}
	doins -r samples || die
}
