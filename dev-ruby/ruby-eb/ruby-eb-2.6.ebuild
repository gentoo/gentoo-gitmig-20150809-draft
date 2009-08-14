# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-eb/ruby-eb-2.6.ebuild,v 1.1 2009/08/14 07:45:43 graaff Exp $

inherit ruby

IUSE=""

MY_P="${P/-/}"
S=${WORKDIR}/${MY_P/a/}

DESCRIPTION="RubyEB is a ruby extension for EB Library"
HOMEPAGE="http://rubyeb.sourceforge.net/"
SRC_URI="http://rubyeb.sourceforge.net/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
USE_RUBY="ruby18"
KEYWORDS="~ia64 ~ppc ~x86"

DEPEND="sys-libs/zlib
	>=dev-libs/eb-4.0-r1"
RDEPEND="${DEPEND}"
