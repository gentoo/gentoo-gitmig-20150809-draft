# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/prawn-core/prawn-core-0.7.1.ebuild,v 1.2 2010/01/28 19:11:39 flameeyes Exp $

EAPI=2
USE_RUBY="ruby18 jruby"

RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="HACKING README"

# ttfunk and pdf-inspector are vendored, and the versions currently
# there are not identical to the versions we already carry in our
# tree. To be fixed.
RUBY_FAKEGEM_EXTRAINSTALL="data vendor"

inherit ruby-fakegem

DESCRIPTION="Fast, Nimble PDF Generation For Ruby"
HOMEPAGE="http://prawn.majesticseacreature.com/"

LICENSE="|| ( GPL-2 Ruby )"
SLOT="0"
KEYWORDS="~amd64"
IUSE="examples"

ruby_add_bdepend test "dev-ruby/test-spec dev-ruby/mocha dev-ruby/pdf-reader"

# Older versions of prawn install the same files, but in site_ruby
# which gets found before the newer gem install path that prawn-core
# uses.
RDEPEND="!<dev-ruby/prawn-0.7"

all_ruby_install() {
	all_fakegem_install

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r examples || die "Installing examples failed."
	fi
}
