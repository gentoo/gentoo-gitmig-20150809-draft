# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-eb/ruby-eb-2.5a.ebuild,v 1.2 2004/04/10 22:29:30 dholm Exp $

inherit ruby

IUSE=""

MY_P="${P/-/}"
S=${WORKDIR}/${MY_P/a/}

DESCRIPTION="RubyEB is a ruby extension for EB Library"
HOMEPAGE="http://rubyeb.sourceforge.net/"
SRC_URI="http://rubyeb.sourceforge.net/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
USE_RUBY="ruby16 ruby18 ruby19"
KEYWORDS="~x86 ~ppc"

DEPEND="sys-libs/zlib
	>=dev-libs/eb-4.0-r1"
