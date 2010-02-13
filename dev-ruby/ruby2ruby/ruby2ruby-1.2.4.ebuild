# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby2ruby/ruby2ruby-1.2.4.ebuild,v 1.5 2010/02/13 19:17:34 armin76 Exp $

inherit gems

DESCRIPTION="Generates readable ruby from ParseTree"
HOMEPAGE="http://seattlerb.rubyforge.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="=dev-ruby/parsetree-3.0*
	=dev-ruby/sexp-processor-3.0*
	=dev-ruby/ruby_parser-2.0*"
RDEPEND="${DEPEND}"

USE_RUBY="ruby18"
