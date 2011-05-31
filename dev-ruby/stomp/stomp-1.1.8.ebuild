# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/stomp/stomp-1.1.8.ebuild,v 1.2 2011/05/31 18:08:48 graaff Exp $

EAPI="2"

USE_RUBY="ruby18 ruby19 ree18"

RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="CHANGELOG.rdoc README.rdoc"

# There is also a test task but that requires a live stomp server.
RUBY_FAKEGEM_TASK_TEST="spec"

inherit ruby-fakegem

DESCRIPTION="Ruby bindings for the stomp messaging protocol"
HOMEPAGE="http://rubyforge.org/projects/stomp/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

ruby_add_bdepend "test? ( dev-ruby/rspec:2 )"
