# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/radiant/radiant-0.7.1.ebuild,v 1.1 2009/02/18 10:37:47 graaff Exp $

inherit ruby gems

DESCRIPTION="A no-fluff, open source content management system"
HOMEPAGE="http://radiantcms.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	>=dev-ruby/rspec-1.1.11
	>=dev-ruby/rspec-rails-1.1.11
	>=dev-ruby/rake-0.8.3"
