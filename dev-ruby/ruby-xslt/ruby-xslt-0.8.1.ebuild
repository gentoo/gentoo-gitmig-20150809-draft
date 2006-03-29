# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-xslt/ruby-xslt-0.8.1.ebuild,v 1.2 2006/03/29 16:08:28 agriffis Exp $

inherit ruby

MY_P="${PN}_${PV}"

DESCRIPTION="A Ruby class for processing XSLT"
HOMEPAGE="http://www.rubyfr.net/"
SRC_URI="http://gregoire.lejeune.free.fr/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ia64 ~x86"
IUSE=""

USE_RUBY="ruby18 ruby19"

DEPEND=">=dev-lang/ruby-1.8"

S="${WORKDIR}/${PN}"
