# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/gen/gen-0.40.0.ebuild,v 1.1 2006/12/07 16:05:58 pclouds Exp $

inherit ruby gems

USE_RUBY="ruby18"
DESCRIPTION="A simple code generation system"
HOMEPAGE="http://www.nitroproject.org/"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~ia64 ~x86 ~amd64"
IUSE=""

DEPEND=">=dev-lang/ruby-1.8.5
	=dev-ruby/glue-${PV}"
