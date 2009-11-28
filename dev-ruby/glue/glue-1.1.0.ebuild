# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/glue/glue-1.1.0.ebuild,v 1.1 2009/11/28 10:23:47 a3li Exp $

inherit ruby gems

DESCRIPTION="Glue utilities for Nitro."
HOMEPAGE="http://www.nitroproject.org/"

LICENSE="|| ( Ruby GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

USE_RUBY="ruby18"
DEPEND=">=dev-lang/ruby-1.8.6
	dev-ruby/httparty"
