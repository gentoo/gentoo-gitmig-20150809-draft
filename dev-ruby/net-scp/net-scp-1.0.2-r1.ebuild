# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/net-scp/net-scp-1.0.2-r1.ebuild,v 1.5 2010/08/15 22:22:04 flameeyes Exp $

EAPI="2"
USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_TASK_DOC="doc"
RUBY_FAKEGEM_EXTRADOC="CHANGELOG.rdoc README.rdoc"

inherit ruby-fakegem

DESCRIPTION="A pure Ruby implementation of the SCP client protocol"
HOMEPAGE="http://net-ssh.rubyforge.org/scp"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""

ruby_add_rdepend ">=dev-ruby/net-ssh-2.0.17-r1"

ruby_add_bdepend "
	doc? ( dev-ruby/echoe )
	test? (
		dev-ruby/echoe
		virtual/ruby-test-unit
		!dev-ruby/test-unit:2
	)"
