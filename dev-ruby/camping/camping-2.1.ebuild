# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/camping/camping-2.1.ebuild,v 1.2 2011/02/23 20:23:27 graaff Exp $

EAPI=2
USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_DOC="docs"
RUBY_FAKEGEM_EXTRADOC="CHANGELOG README"

inherit ruby-fakegem

DESCRIPTION="A small web framework modeled after Ruby on Rails."
HOMEPAGE="http://code.whytheluckystiff.net/camping/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="mongrel"

ruby_add_bdepend "test? ( dev-ruby/markaby )"

ruby_add_rdepend "
	>=dev-ruby/rack-1.0
	mongrel? ( www-servers/mongrel )"
