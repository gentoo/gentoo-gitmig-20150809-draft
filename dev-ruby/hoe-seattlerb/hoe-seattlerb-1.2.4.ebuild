# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/hoe-seattlerb/hoe-seattlerb-1.2.4.ebuild,v 1.5 2011/03/08 07:41:29 tomka Exp $

EAPI=2
USE_RUBY="ruby18 ree18 jruby"

# no tests present
RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_TASK_DOC="docs"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="README.txt History.txt"

inherit ruby-fakegem

DESCRIPTION="Hoe plugins providing tasks used by seattle.rb"
HOMEPAGE="http://seattlerb.rubyforge.org/hoe-seattlerb"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE=""

ruby_add_rdepend '>=dev-ruby/hoe-2.8.0 >=dev-ruby/minitest-2.0.0'
ruby_add_bdepend "doc? ( >=dev-ruby/hoe-2.2.3 )"
