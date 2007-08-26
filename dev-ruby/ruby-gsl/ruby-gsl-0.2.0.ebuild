# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gsl/ruby-gsl-0.2.0.ebuild,v 1.1 2007/08/26 20:20:39 graaff Exp $

inherit ruby

DESCRIPTION="Ruby wrapper for GNU Scientific Library"
HOMEPAGE="http://ruby-gsl.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="sci-libs/gsl
		dev-lang/ruby"
RDEPEND="${DEPEND}"

S="${S}/ext"
