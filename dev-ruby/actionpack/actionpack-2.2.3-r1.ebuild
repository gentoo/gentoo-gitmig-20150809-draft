# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/actionpack/actionpack-2.2.3-r1.ebuild,v 1.3 2009/11/30 17:58:59 ranger Exp $

inherit ruby gems
USE_RUBY="ruby18"

DESCRIPTION="Eases web-request routing, handling, and response."
HOMEPAGE="http://rubyforge.org/projects/actionpack/"

LICENSE="MIT"
SLOT="2.2"
KEYWORDS="amd64 ~ia64 ~ppc ppc64 ~sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=">=dev-lang/ruby-1.8.5
	=dev-ruby/activesupport-2.2.3"

src_install() {
	gems_src_install

	# Patch for bug 294797.
	# Yes, I know, but we cannot patch gems in a different way *yet*.
	cd "${D}/$(gem18 env gemdir)/gems/${P}/lib" || die "cd failed"
	epatch "${FILESDIR}/${P}-strip_tags.patch"
}
