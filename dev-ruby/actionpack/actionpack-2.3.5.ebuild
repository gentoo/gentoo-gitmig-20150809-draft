# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/actionpack/actionpack-2.3.5.ebuild,v 1.9 2011/06/19 09:48:46 a3li Exp $

inherit ruby gems
USE_RUBY="ruby18"

DESCRIPTION="Eases web-request routing, handling, and response."
HOMEPAGE="http://rubyforge.org/projects/actionpack/"

LICENSE="MIT"
SLOT="2.3"
KEYWORDS="amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE=""

DEPEND=">=dev-lang/ruby-1.8.6
	~dev-ruby/activesupport-${PV}
	=dev-ruby/rack-1.0*"
RDEPEND="${DEPEND}"
