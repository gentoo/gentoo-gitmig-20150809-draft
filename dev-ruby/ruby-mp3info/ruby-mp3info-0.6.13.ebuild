# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-mp3info/ruby-mp3info-0.6.13.ebuild,v 1.1 2009/06/02 05:32:38 graaff Exp $

inherit ruby gems

DESCRIPTION="A pure Ruby library for access to mp3 files (internal infos and tags)"
HOMEPAGE="http://rubyforge.org/projects/ruby-mp3info/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86"
USE_RUBY="ruby18"

IUSE=""
RDEPEND=">=dev-ruby/rubygems-1.3.1"
