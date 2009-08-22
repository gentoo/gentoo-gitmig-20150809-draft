# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/palmtree/palmtree-0.0.6.ebuild,v 1.2 2009/08/22 21:02:11 graaff Exp $

inherit gems

USE_RUBY="ruby18"
DESCRIPTION="Assortment of Capistrano recipes for managing other aspects of your Rails application."
HOMEPAGE="http://rubyforge.org/projects/palmtree/"

LICENSE="MIT"
SLOT="1.2"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-ruby/capistrano-1.99.1"
RDEPEND="${DEPEND}"
