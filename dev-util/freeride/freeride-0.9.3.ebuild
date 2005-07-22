# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/freeride/freeride-0.9.3.ebuild,v 1.2 2005/07/22 17:22:48 dholm Exp $

inherit ruby eutils

DESCRIPTION="FreeRIDE is a pure Ruby Integrated Development Environment."
HOMEPAGE="http://freeride.rubyforge.org/"
SRC_URI="http://rubyforge.org/frs/download.php/3148/${P}.tar.gz"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

USE_RUBY="any"

RDEPEND="virtual/ruby
	>=x11-libs/fox-1.2
	>=dev-ruby/fxruby-1.2
	>=x11-libs/fxscintilla-1.61"

src_install() {
	siteruby=$(${RUBY} -r rbconfig -e 'print Config::CONFIG["sitedir"]')
	insinto "${siteruby}/${PN}"
	doins *.rb || "doins *.rb failed"

	cp -R config freebase plugins redist so test \
		"${D}${siteruby}/${PN}" || die "cp -R failed"

	newbin ${FILESDIR}/freeride.sh freeride || die "dobin failed"

	erubydoc
}
