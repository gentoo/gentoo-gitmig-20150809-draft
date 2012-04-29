# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/chef-server/chef-server-0.10.10_beta1.ebuild,v 1.1 2012/04/29 13:26:30 hollow Exp $

EAPI="4"
USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST=""
RUBY_FAKEGEM_VERSION=${PV/_beta/.beta.}

inherit ruby-fakegem

DESCRIPTION="Configuration management tool (meta package)"
HOMEPAGE="http://wiki.opscode.com/display/chef"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend "~app-admin/chef-server-api-${PV}
	~app-admin/chef-solr-${PV}
	~app-admin/chef-expander-${PV}"
