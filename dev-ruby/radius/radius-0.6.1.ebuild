# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/radius/radius-0.6.1.ebuild,v 1.1 2009/10/03 12:52:12 a3li Exp $

inherit ruby gems

USE_RUBY="ruby18"
DESCRIPTION="Powerful tag-based template system."
HOMEPAGE="http://radius.rubyforge.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
RESTRICT="test"

DEPEND=">=dev-lang/ruby-1.8.6"
