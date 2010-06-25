# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/facets/facets-2.8.4.ebuild,v 1.1 2010/06/25 06:52:54 graaff Exp $

EAPI=2
USE_RUBY="ruby18"

RUBY_FAKEGEM_EXTRADOC="AUTHORS HISTORY.rdoc NOTES README.rdoc demo/hook.rdoc demo/scenario_require.rdoc"

inherit ruby-fakegem

DESCRIPTION="Facets is an extension library adding extra functionality to Ruby"
HOMEPAGE="http://facets.rubyforge.org/"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""

all_ruby_prepare() {
	mkdir -p doc/rdoc || die "Unable to make directory for documentation."
}
