# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/aws-sdk/aws-sdk-1.5.5.ebuild,v 1.1 2012/06/27 10:43:37 flameeyes Exp $

EAPI=4

USE_RUBY="ruby18 ruby19 ree18"

RUBY_FAKEGEM_TASK_TEST=""
RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="README.rdoc"

RUBY_FAKEGEM_EXTRAINSTALL="ca-bundle.crt"

GITHUB_USER="amazonwebservices"
GITHUB_PROJECT="${PN}-for-ruby"
RUBY_S="${GITHUB_USER}-${GITHUB_PROJECT}-*"

RUBY_FAKEGEM_GEMSPEC="${T}/${P}.gemspec"

inherit ruby-fakegem

DESCRIPTION="Official SDK for Amazon Web Services"
HOMEPAGE="http://aws.amazon.com/sdkforruby"
SRC_URI="https://github.com/${GITHUB_USER}/${GITHUB_PROJECT}/tarball/${PV} -> ${GITHUB_PROJECT}-${PV}.tar.gz"

LICENSE="APSL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_rdepend "virtual/ruby-ssl
	>=dev-ruby/httparty-0.7
	>=dev-ruby/json-1.4
	>=dev-ruby/nokogiri-1.4.4
	>=dev-ruby/uuidtools-2.1"
ruby_add_bdepend "
	test? ( dev-ruby/rspec )"

all_ruby_prepare() {
	rm Gemfile* || die

	epatch "${FILESDIR}"/${PN}-1.5.3-disabletest.patch
}

all_ruby_compile() {
	if use doc; then
		rdoc || die
	fi
}

each_ruby_test() {
	${RUBY} -S rspec -Ilib -raws || die
}

each_ruby_install() {
	sed -e "s:VERSION:${PV}:" "${FILESDIR}"/${PN}.gemspec > "${RUBY_FAKEGEM_GEMSPEC}"
	each_fakegem_install
}

all_ruby_install() {
	all_fakegem_install

	insinto /usr/share/doc/${PF}
	doins -r recipebook samples
}
