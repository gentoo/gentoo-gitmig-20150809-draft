# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/mongrel_cluster/mongrel_cluster-0.2.2.ebuild,v 1.2 2007/06/05 03:51:11 nichoj Exp $

inherit ruby gems

DESCRIPTION="Mongrel plugin that provides commands and Capistrano tasks for managing multiple Mongrel processes"
HOMEPAGE="http://mongrel.rubyforge.org/docs/mongrel_cluster.html"
SRC_URI="http://mongrel.rubyforge.org/releases/gems/${P}.gem"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

USE_RUBY="any"
DEPEND=">=www-servers/mongrel-1.0.1
	>=dev-ruby/gem_plugin-0.2.2"
#
#src_install()
#{
#	gems_src_install
#
#	EPATCH_OPTS="-d ${D}/${GEMSDIR}/gems/${P}"
#	epatch ${FILESDIR}/mongrel_cluster_ctl.patch
#
#	dodir /etc/mongrel_cluster
#
#	newinitd ${FILESDIR}/mongrel_cluster.init mongrel_cluster
#	newconfd ${FILESDIR}/mongrel_cluster.conf mongrel_cluster
#}
