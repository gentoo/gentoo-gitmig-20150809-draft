# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/hoe-seattlerb/hoe-seattlerb-1.2.2.ebuild,v 1.9 2010/10/28 16:45:09 phajdan.jr Exp $

EAPI=2
USE_RUBY="ruby18 jruby"

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
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc x86"
IUSE=""

ruby_add_rdepend '>=dev-ruby/hoe-2.3.3 dev-ruby/minitest'
ruby_add_bdepend "doc? ( >=dev-ruby/hoe-2.3.3 )"
