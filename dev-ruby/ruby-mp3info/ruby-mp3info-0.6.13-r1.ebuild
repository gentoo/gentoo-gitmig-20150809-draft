# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-mp3info/ruby-mp3info-0.6.13-r1.ebuild,v 1.2 2011/06/24 14:35:32 armin76 Exp $

EAPI=2
USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_DOC="docs"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="History.txt README.txt"

inherit ruby-fakegem

DESCRIPTION="A pure Ruby library for access to mp3 files (internal infos and tags)"
HOMEPAGE="http://rubyforge.org/projects/ruby-mp3info/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

# Tests are broken due to missing fixture files.
RESTRICT="test"

ruby_add_bdepend "doc? ( dev-ruby/hoe )"
ruby_add_bdepend "test? ( dev-ruby/hoe )"
