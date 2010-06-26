# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/transaction-simple/transaction-simple-1.4.0-r1.ebuild,v 1.1 2010/06/26 19:14:51 graaff Exp $

EAPI=2
USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_DOC="docs"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="History.txt Readme.txt"

inherit ruby-fakegem

DESCRIPTION="Provides transaction support at the object level"
HOMEPAGE="http://rubyforge.org/projects/trans-simple/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"
IUSE=""

ruby_add_bdepend "test? ( dev-ruby/hoe ) doc? ( dev-ruby/hoe )"
