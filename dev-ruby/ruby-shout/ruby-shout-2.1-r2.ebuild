# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-shout/ruby-shout-2.1-r2.ebuild,v 1.2 2010/01/29 12:38:42 flameeyes Exp $

EAPI=2

USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_TASK_TEST=""
RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_EXTRADOC="README example.rb"

inherit ruby-fakegem eutils

DESCRIPTION="A Ruby interface to libshout2"
HOMEPAGE="http://ruby-shout.rubyforge.org/"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=media-libs/libshout-2.0"
DEPEND="${RDEPEND}"

all_ruby_prepare() {
	epatch "${FILESDIR}"/${P}+ruby-1.9.patch
}

each_ruby_configure() {
	pushd ext &>/dev/null
	${RUBY} extconf.rb || die "extconf failed"
	popd &>/dev/null
}

each_ruby_compile() {
	pushd ext &>/dev/null
	emake || die "emake failed"
	popd &>/dev/null
}

each_ruby_install() {
	each_fakegem_install

	pushd ext &>/dev/null
	ruby_fakegem_newins ${PN#ruby-}.so lib/${PN#ruby-}.so
	popd &>/dev/null
}
