# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-progressbar/ruby-progressbar-0.8.ebuild,v 1.13 2006/12/04 04:08:31 weeve Exp $

inherit ruby

DESCRIPTION="A Text Progress Bar Library for Ruby"
HOMEPAGE="http://www.namazu.org/~satoru/ruby-progressbar/"
SRC_URI="http://namazu.org/~satoru/ruby-progressbar/${P}.tar.gz"

LICENSE="Ruby"
SLOT="0"
USE_RUBY="any"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"

IUSE=""

DEPEND="virtual/ruby"
