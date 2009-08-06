# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby_parser/ruby_parser-2.0.3.ebuild,v 1.1 2009/08/06 06:20:36 graaff Exp $

inherit gems

DESCRIPTION="A ruby parser written in pure ruby."
HOMEPAGE="http://parsetree.rubyforge.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

USE_RUBY="ruby18"

DEPEND=">=dev-ruby/sexp-processor-3.0.1"
RDEPEND="${DEPEND}"
