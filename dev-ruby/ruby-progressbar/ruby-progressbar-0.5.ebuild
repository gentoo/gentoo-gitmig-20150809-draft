# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-progressbar/ruby-progressbar-0.5.ebuild,v 1.1 2003/12/25 10:05:05 usata Exp $

inherit ruby

DESCRIPTION="A Text Progress Bar Library for Ruby"
HOMEPAGE="http://www.namazu.org/~satoru/ruby-progressbar/"
SRC_URI="http://namazu.org/~satoru/ruby-progressbar/${P}.tar.gz"

LICENSE="Ruby"
SLOT="0"
USE_RUBY="any"
KEYWORDS="~x86"

IUSE=""

DEPEND="dev-lang/ruby"
#RDEPEND=""

S=${WORKDIR}/${P}
