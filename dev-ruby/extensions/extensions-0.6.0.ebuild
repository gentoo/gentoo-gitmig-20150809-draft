# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/extensions/extensions-0.6.0.ebuild,v 1.8 2010/05/22 15:13:18 flameeyes Exp $

inherit ruby gems

USE_RUBY="ruby18"
DESCRIPTION="Extensions to the standard Ruby library"
HOMEPAGE="http://rubyforge.org/projects/extensions/"
# The URL depends implicitly on the version, unfortunately. Even if you
# change the filename on the end, it still downloads the same file.

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ia64 ppc64 x86"
IUSE=""

DEPEND=">=dev-lang/ruby-1.8.2"
