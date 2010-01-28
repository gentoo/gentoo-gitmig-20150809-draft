# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/shotgun/shotgun-0.6.ebuild,v 1.1 2010/01/28 16:27:38 flameeyes Exp $

EAPI=2
USE_RUBY="ruby18"

# No documentation task
RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_EXTRADOC="README"

inherit ruby-fakegem

DESCRIPTION="Forking implementation of rackup"
HOMEPAGE="http://rtomayko.github.com/shotgun/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# Warning: the code does not use gem versioning to make sure to load
# only the right rack version so we might need to patch it to work :/
ruby_add_rdepend '=dev-ruby/rack-1.0*'
ruby_add_bdepend test dev-ruby/bacon
