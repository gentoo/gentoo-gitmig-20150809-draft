# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/net-ssh-multi/net-ssh-multi-1.0.1-r1.ebuild,v 1.1 2010/06/26 18:47:21 graaff Exp $

EAPI=2
USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_DOC="docs"
RUBY_FAKEGEM_DOCDIR="doc"

RUBY_FAKEGEM_EXTRADOC="CHANGELOG.rdoc README.rdoc"

inherit ruby-fakegem

DESCRIPTION="Net::SSH::Multi is a library for controlling multiple Net::SSH
connections via a single interface."
HOMEPAGE="http://net-ssh.rubyforge.org/multi"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~x86"
IUSE=""

ruby_add_bdepend "dev-ruby/echoe"
ruby_add_rdepend ">=dev-ruby/net-ssh-2.0.10"
