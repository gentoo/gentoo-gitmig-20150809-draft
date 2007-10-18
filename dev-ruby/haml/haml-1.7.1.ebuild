# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/haml/haml-1.7.1.ebuild,v 1.3 2007/10/18 19:45:43 graaff Exp $

inherit ruby gems

DESCRIPTION="HAML - a ruby web page templating engine"
HOMEPAGE="http://rubyforge.org/projects/haml/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ruby-1.8.4
	dev-ruby/activesupport"
