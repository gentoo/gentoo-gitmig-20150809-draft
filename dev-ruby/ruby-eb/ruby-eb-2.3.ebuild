# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-eb/ruby-eb-2.3.ebuild,v 1.3 2003/11/15 17:48:20 usata Exp $

inherit ruby

IUSE=""

MY_P="${P/-/}"

DESCRIPTION="RubyEB is a ruby extension for EB Library"
HOMEPAGE="http://rubyeb.sourceforge.net/"
SRC_URI="http://rubyeb.sourceforge.net/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
USE_RUBY="1.6 1.8"
KEYWORDS="~x86"

DEPEND="sys-libs/zlib
	dev-libs/eb"

S="${WORKDIR}/${MY_P}"
