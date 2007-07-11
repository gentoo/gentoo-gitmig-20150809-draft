# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/podcatcher/podcatcher-1.3.7.ebuild,v 1.3 2007/07/11 19:30:23 mr_bones_ Exp $

DESCRIPTION="A podcast client for the command-line written in Ruby."
HOMEPAGE="http://podcatcher.rubyforge.org/"
SRC_URI="http://rubyforge.org/frs/download.php/12967/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="bittorrent"

DEPEND=">=dev-lang/ruby-1.8.2
	bittorrent? ( dev-ruby/rubytorrent )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

src_install() {
	dobin podcatcher
	dodoc README sample.opml sample.pcast
}
