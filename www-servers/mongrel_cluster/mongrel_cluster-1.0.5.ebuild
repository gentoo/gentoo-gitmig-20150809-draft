# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/mongrel_cluster/mongrel_cluster-1.0.5.ebuild,v 1.1 2007/12/16 02:47:59 nichoj Exp $

inherit ruby gems

DESCRIPTION="Mongrel plugin that provides commands and Capistrano tasks for managing multiple Mongrel processes"
HOMEPAGE="http://mongrel.rubyforge.org/docs/mongrel_cluster.html"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

USE_RUBY="any"
DEPEND=">=www-servers/mongrel-1.0.2
	>=dev-ruby/gem_plugin-0.2.3"
