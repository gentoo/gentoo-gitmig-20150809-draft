# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/actionpack/actionpack-1.13.3.ebuild,v 1.2 2007/10/05 21:26:06 fmccor Exp $

inherit ruby gems

USE_RUBY="ruby18"
DESCRIPTION="Eases web-request routing, handling, and response."
HOMEPAGE="http://rubyforge.org/projects/actionpack/"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

LICENSE="MIT"
SLOT="1.2"
KEYWORDS="~amd64 ~ia64 ~ppc sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND=">=dev-lang/ruby-1.8.5
	=dev-ruby/activesupport-1.4.2"
