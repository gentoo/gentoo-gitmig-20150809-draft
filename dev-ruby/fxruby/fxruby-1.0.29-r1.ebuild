# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/fxruby/fxruby-1.0.29-r1.ebuild,v 1.1 2005/05/07 19:53:58 rphillips Exp $

inherit ruby

MY_P="FXRuby-${PV}"

DESCRIPTION="Ruby language binding to the FOX GUI toolkit"
HOMEPAGE="http://www.fxruby.org/"
SRC_URI="http://rubyforge.org/frs/download.php/983/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="-alpha -hppa ~sparc ~x86 ~ppc"
IUSE="doc"

DEPEND="virtual/ruby
	=x11-libs/fox-1.0*
	>=x11-libs/fxscintilla-1.62-r1"
USE_RUBY="ruby16 ruby18 ruby19"

S="${WORKDIR}/${MY_P}"
