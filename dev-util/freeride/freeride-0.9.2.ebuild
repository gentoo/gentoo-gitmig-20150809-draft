# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/freeride/freeride-0.9.2.ebuild,v 1.3 2007/06/26 02:03:38 mr_bones_ Exp $

inherit ruby eutils

DESCRIPTION="FreeRIDE is a pure Ruby Integrated Development Environment."
HOMEPAGE="http://freeride.rubyforge.org/"
SRC_URI="http://rubyforge.org/frs/download.php/2185/${P}.tar.gz"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="x86"
IUSE=""

USE_RUBY="any"

RDEPEND="virtual/ruby
	>=x11-libs/fox-1.2
	>=dev-ruby/fxruby-1.2
	>=x11-libs/fxscintilla-1.61"

src_unpack() {
	unpack ${A}
	cd ${S}/plugins/rubyide_fox_gui

	# A little patch I've created from FR CVS. Probably won't be
	# needed in future versions.
	epatch ${FILESDIR}/${P}-gentoo-appframe.patch
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
