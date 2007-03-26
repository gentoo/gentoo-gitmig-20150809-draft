# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/webgen/webgen-0.4.2.ebuild,v 1.1 2007/03/26 13:16:02 pclouds Exp $

inherit ruby gems

DESCRIPTION="A template based static website generator"
HOMEPAGE="http://webgen.rubyforge.org/"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="textile markdown thumbnail"
DEPEND=">=dev-ruby/cmdparse-2.0.0
	textile? ( >=dev-ruby/redcloth-2.0.10 )
	markdown? ( >=dev-ruby/bluecloth-1.0.0 )
	thumbnail? ( >=dev-ruby/rmagick-1.7.1 )"
