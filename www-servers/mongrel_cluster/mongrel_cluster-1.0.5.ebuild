# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/mongrel_cluster/mongrel_cluster-1.0.5.ebuild,v 1.2 2009/08/18 11:10:30 a3li Exp $

inherit ruby gems

DESCRIPTION="Mongrel plugin that provides commands and Capistrano tasks for managing multiple Mongrel processes"
HOMEPAGE="http://mongrel.rubyforge.org/docs/mongrel_cluster.html"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

USE_RUBY="ruby18"
DEPEND=">=www-servers/mongrel-1.0.2
	>=dev-ruby/gem_plugin-0.2.3"
RDEPEND="${DEPEND}"
