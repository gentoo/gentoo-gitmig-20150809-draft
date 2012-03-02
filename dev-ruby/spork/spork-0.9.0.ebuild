# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/spork/spork-0.9.0.ebuild,v 1.2 2012/03/02 13:38:51 naota Exp $

EAPI=2

USE_RUBY="ruby18 ruby19 ree18"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README.rdoc"
RUBY_FAKEGEM_EXTRAINSTALL="assets"

inherit ruby-fakegem

DESCRIPTION="Spork is Tim Harper's implementation of test server."
HOMEPAGE="http://github.com/timcharper/spork"
LICENSE="MIT"

KEYWORDS="~amd64 ~x86 ~x86-fbsd"
SLOT="0"
IUSE=""

ruby_add_bdepend "test? ( >=dev-ruby/rspec-2.6:2 )"

each_ruby_test() {
	${RUBY} -S rspec spec || die
	# The features need a very fiddly and particular rails setup which
	# we can't easily garantee.
	#${RUBY} -Ilib -S cucumber features || die
}
