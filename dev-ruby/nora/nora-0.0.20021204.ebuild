# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/nora/nora-0.0.20021204.ebuild,v 1.1 2004/02/28 17:22:10 usata Exp $

inherit ruby

IUSE=""

MY_P="${PN}-${PV##*.}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Nora - ruby libraries for web application library"
HOMEPAGE="http://raa.ruby-lang.org/list.rhtml?name=nora"
SRC_URI="http://www.moonwolf.com/ruby/archive/${MY_P}.tar.gz"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="x86"
USE_RUBY="ruby16 ruby18 ruby19"
