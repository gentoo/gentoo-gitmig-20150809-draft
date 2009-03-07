# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/podcatcher/podcatcher-3.1.4.ebuild,v 1.1 2009/03/07 16:41:05 patrick Exp $

DESCRIPTION="Podcast client for the command-line written in Ruby."
HOMEPAGE="http://podcatcher.rubyforge.org"
SRC_URI="http://rubyforge.org/frs/download.php/43722/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="bittorrent"

DEPEND=">=dev-lang/ruby-1.8.2
	bittorrent? ( dev-ruby/rubytorrent )"
RDEPEND="${DEPEND}"

S="${WORKDIR}"/${PN}

src_install() {
	dobin bin/podcatcher
	dodoc demo/*
}
