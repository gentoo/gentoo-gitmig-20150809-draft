# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/freeride/freeride-0.6.0.ebuild,v 1.4 2004/07/14 23:28:05 agriffis Exp $

inherit ruby eutils

DESCRIPTION="FreeRIDE is a pure Ruby Integrated Development Environment."
HOMEPAGE="http://freeride.rubyforge.org/"
SRC_URI="http://rubyforge.org/frs/download.php/256/${P}.tgz"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

USE_RUBY="any"
DEPEND="virtual/ruby
	>=x11-libs/fox-1.0.27
	>=dev-ruby/fxruby-1.0.18
	>=x11-libs/fxscintilla-1.49"
#RDEPEND=""

src_unpack() {
	unpack ${A}
	cd ${S}

	# This patch fixes a bug which causes FR to use installdir/config
	# instead of ~/.freeride for the config-files.
	epatch ${FILESDIR}/${P}-gentoo-properties.diff
}

src_install() {
	siteruby=$(${RUBY} -r rbconfig -e 'print Config::CONFIG["sitedir"]')
	insinto "${siteruby}/${PN}"
	doins *.rb || "doins *.rb failed"

	cp -R config freebase plugins redist so test \
		"${D}${siteruby}/${PN}" || die "cp -R failed"

	newbin ${FILESDIR}/freeride.sh freeride || die "dobin failed"

	erubydoc
}
