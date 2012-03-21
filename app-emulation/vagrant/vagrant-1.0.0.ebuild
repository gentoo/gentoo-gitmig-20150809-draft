# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/vagrant/vagrant-1.0.0.ebuild,v 1.1 2012/03/21 07:08:08 radhermit Exp $

EAPI="4"
USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_EXTRADOC="CHANGELOG.md README.md"
RUBY_FAKEGEM_GEMSPEC="vagrant.gemspec"
RUBY_FAKEGEM_EXTRAINSTALL="config keys templates"

inherit ruby-fakegem

DESCRIPTION="A tool for building and distributing virtual machines using VirtualBox"
HOMEPAGE="http://vagrantup.com/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

# Missing ebuild for contest
RESTRICT="test"

RDEPEND="${RDEPEND}
	|| ( app-emulation/virtualbox app-emulation/virtualbox-bin )"

ruby_add_rdepend "
	~dev-ruby/archive-tar-minitar-0.5.2
	>=dev-ruby/childprocess-0.3.1
	>=dev-ruby/erubis-2.7.0
	>=dev-ruby/i18n-0.6.0
	>=dev-ruby/json-1.5.1
	>=dev-ruby/log4r-1.1.9
	>=dev-ruby/net-scp-1.0.4
	>=dev-ruby/net-ssh-2.2.2
"

ruby_add_bdepend "
	dev-ruby/rake
	test? ( dev-ruby/mocha virtual/ruby-minitest )
"

all_ruby_prepare() {
	# Remove bundler support
	sed -i -e '/[Bb]undler/d' Rakefile || die
	rm Gemfile || die

	# Loosen unslotted dependencies
	sed -i -e '/json\|net-ssh/s/~>/>=/' ${PN}.gemspec || die

	# Remove a runtime dependency that we can't satisfy
	sed -i -e '/git ls-files/d' ${PN}.gemspec || die
}
