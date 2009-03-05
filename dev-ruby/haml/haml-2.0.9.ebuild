# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/haml/haml-2.0.9.ebuild,v 1.1 2009/03/05 06:57:42 graaff Exp $

inherit ruby gems

DESCRIPTION="HAML - a ruby web page templating engine"
HOMEPAGE="http://haml.hamptoncatlin.com/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND="
	>=dev-lang/ruby-1.8.6
	dev-ruby/activesupport
	dev-ruby/hpricot"
