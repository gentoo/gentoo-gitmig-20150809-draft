# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gettext/ruby-gettext-2.1.0_p20100728-r1.ebuild,v 1.8 2012/05/01 18:24:10 armin76 Exp $

EAPI=2

USE_RUBY="ruby18 jruby ree18"

RUBY_FAKEGEM_NAME="${PN/ruby-/}"
RUBY_FAKEGEM_VERSION="${PV%_*}"

RUBY_FAKEGEM_TASK_DOC="rerdoc"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="ChangeLog ChangeLog-1 NEWS-1 README.rdoc"

RUBY_FAKEGEM_TASK_TEST="test"

RUBY_FAKEGEM_EXTRAINSTALL="data"

inherit ruby-fakegem

DESCRIPTION="Ruby GetText Package is Native Language Support Library and Tools modeled after GNU gettext package"
HOMEPAGE="http://www.yotabanana.com/hiki/ruby-gettext.html"
SRC_URI="http://dev.a3li.li/gentoo/distfiles/${P}.tar.bz2"

KEYWORDS="amd64 ppc x86 ~x86-fbsd ~x86-macos"
IUSE=""
SLOT="0"
LICENSE="Ruby"

ruby_add_rdepend ">=dev-ruby/locale-2.0.5"

RDEPEND="${RDEPEND}
	sys-devel/gettext"
DEPEND="${DEPEND}
	sys-devel/gettext"

ruby_add_bdepend "test? ( || ( virtual/ruby-test-unit dev-ruby/test-unit:2 ) )"

all_ruby_prepare() {
	# Allison 2.0.3 produces illegal HTML which markaby doesn't like.
	sed -i '/allison/d' Rakefile || die
}

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
