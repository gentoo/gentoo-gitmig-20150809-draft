# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/sary-ruby/sary-ruby-0.5_pre20030507.ebuild,v 1.5 2003/12/24 22:18:13 usata Exp $

inherit ruby

IUSE=""

MY_PN="${PN/-/-cvs-}"

DESCRIPTION="Ruby Binding of Sary"
HOMEPAGE="http://sary.namazu.org/#ruby
	http://taiyaki.org/prime/"
SRC_URI="http://taiyaki.org/tmp/sary/${MY_PN}_${PV/*_pre/}.tar.gz"
#SRC_URI="ftp://ftp.namazu.org/sary/ruby/${P}.tar.gz"
PATCHES="${FILESDIR}/${P}-gentoo.diff"

LICENSE="LGPL-2.1"
KEYWORDS="x86"
SLOT="0"
USE_RUBY="ruby16 ruby18"
S="${WORKDIR}/${PN}"

DEPEND=">=app-text/sary-1.0.3"
