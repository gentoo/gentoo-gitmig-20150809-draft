# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/rubygfe/rubygfe-0.3.4.ebuild,v 1.1 2008/02/23 10:12:30 pclouds Exp $

inherit ruby

DESCRIPTION="RubyGFE -- A Game File Extractor"
HOMEPAGE="http://fox.gentoo-clan.org/rubygfe"
SRC_URI="http://rubyforge.org/frs/download.php/29936/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="nls gtk"

DEPEND="gtk? ( >=dev-ruby/ruby-gtk2-0.12.0 )
		nls? ( >=dev-ruby/ruby-gettext-0.8.0 )
		>=dev-ruby/rubyzip-0.5.7"
