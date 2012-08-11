# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/mixlib-config/mixlib-config-1.1.2.ebuild,v 1.3 2012/08/11 08:34:29 hollow Exp $

EAPI=4
USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST="none"

RUBY_FAKEGEM_EXTRADOC="NOTICE README.rdoc"

inherit ruby-fakegem

DESCRIPTION="Simple class based Config mechanism"
HOMEPAGE="http://github.com/opscode/mixlib-config"
SRC_URI="https://github.com/opscode/${PN}/tarball/${PV} -> ${P}.tgz"
RUBY_S="opscode-${PN}-*"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE=""

ruby_add_bdepend "test? (
	dev-ruby/rspec:2
	dev-util/cucumber
)"

each_ruby_test() {
	${RUBY} -S rspec spec || die
	${RUBY} -S cucumber features || die
}
