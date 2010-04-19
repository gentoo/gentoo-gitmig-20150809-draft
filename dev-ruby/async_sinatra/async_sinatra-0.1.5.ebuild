# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/async_sinatra/async_sinatra-0.1.5.ebuild,v 1.1 2010/04/19 18:09:22 flameeyes Exp $

EAPI="2"
USE_RUBY="ruby18"

RUBY_FAKEGEM_DOCDIR="html"
RUBY_FAKEGEM_EXTRADOC="README.rdoc"

# there are no tests
RUBY_FAKEGEM_TASK_TEST=""

# the documentation-building requires the gemspec file that is not
# packaged, this is very unfortunate for us, but the doc does not
# really tell us much so we're not going out of our way to get this
# from GIT.
RUBY_FAKEGEM_TASK_DOC=""

inherit ruby-fakegem

DESCRIPTION="Asynchronous response API for Sinatra and Thin"
HOMEPAGE="http://rubyeventmachine.com"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_rdepend '>=dev-ruby/sinatra-0.9.1
	>=www-servers/thin-1.2.0'

all_ruby_install() {
	all_fakegem_install

	insinto /usr/share/doc/${PF}/
	doins -r examples || die "Failed to install examples"
}
