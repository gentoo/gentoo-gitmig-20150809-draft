# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/main/main-4.2.0.ebuild,v 1.1 2009/11/27 07:06:19 graaff Exp $

inherit ruby gems

USE_RUBY="ruby18"
DESCRIPTION="A class factory and dsl for generating command line programs real quick."
HOMEPAGE="http://rubyforge.org/projects/codeforpeople"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-ruby/fattr-2.1.0
	>=dev-ruby/arrayfields-4.7.4"
DEPEND="${RDEPEND}"
