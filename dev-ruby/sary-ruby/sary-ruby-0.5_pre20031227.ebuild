# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/sary-ruby/sary-ruby-0.5_pre20031227.ebuild,v 1.1 2004/01/11 16:57:01 usata Exp $

inherit ruby

IUSE=""

MY_PN="${PN/-/-cvs-}"

DESCRIPTION="Ruby Binding of Sary"
HOMEPAGE="http://sary.namazu.org/#ruby
	http://taiyaki.org/prime/"
SRC_URI="http://dev.gentoo.org/~usata/distfiles/${MY_PN}_${PV/*_pre/}.tar.gz
	http://taiyaki.org/tmp/sary/${MY_PN}_${PV/*_pre/}.tar.gz"
#SRC_URI="ftp://ftp.namazu.org/sary/ruby/${P}.tar.gz"

LICENSE="LGPL-2.1"
KEYWORDS="~x86"
SLOT="0"
USE_RUBY="ruby16 ruby18"
S="${WORKDIR}/${PN}"

DEPEND=">=app-text/sary-1.0.3"
