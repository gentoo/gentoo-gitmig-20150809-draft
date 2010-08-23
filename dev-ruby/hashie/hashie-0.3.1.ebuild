# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/hashie/hashie-0.3.1.ebuild,v 1.1 2010/08/23 06:23:25 graaff Exp $

EAPI="2"
USE_RUBY="ruby18 ruby19 jruby ree18"

RUBY_FAKEGEM_TASK_TEST="spec"

RUBY_FAKEGEM_DOCDIR="rdoc"
RUBY_FAKEGEM_EXTRADOC="README.rdoc"

inherit ruby-fakegem

DESCRIPTION="Hashie is a small collection of tools that make hashes more powerful."
HOMEPAGE="http://intridea.com/posts/hashie-the-hash-toolkit"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_bdepend "test? ( dev-ruby/rspec dev-ruby/json )"
