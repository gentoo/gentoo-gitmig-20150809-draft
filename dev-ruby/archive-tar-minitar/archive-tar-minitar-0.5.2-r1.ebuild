# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/archive-tar-minitar/archive-tar-minitar-0.5.2-r1.ebuild,v 1.9 2010/08/29 18:01:08 armin76 Exp $

EAPI=2
USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_TEST=""
RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_EXTRADOC="README ChangeLog"

inherit ruby-fakegem

DESCRIPTION="Provides POSIX tarchive management from Ruby programs."
HOMEPAGE="http://rubyforge.org/projects/ruwiki/"
SRC_URI="mirror://rubyforge/ruwiki/${P}.tar.gz"

LICENSE="|| ( GPL-2 Ruby )"
SLOT="0"
KEYWORDS="amd64 ia64 ~ppc ~ppc64 ~sparc x86"
IUSE=""

RESTRICT="test"
