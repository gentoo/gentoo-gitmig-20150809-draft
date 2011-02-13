# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/diff-lcs/diff-lcs-1.1.2-r2.ebuild,v 1.7 2011/02/13 12:27:46 armin76 Exp $

EAPI=2
USE_RUBY="ruby18 ree18 jruby"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README ChangeLog"

inherit ruby-fakegem

DESCRIPTION="Use the McIlroy-Hunt LCS algorithm to compute differences"
HOMEPAGE="http://rubyforge.org/projects/ruwiki/"
SRC_URI="mirror://rubyforge/ruwiki/${P}.tar.gz"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="amd64 ~hppa ia64 ~ppc ~ppc64 ~sparc x86 ~x86-fbsd"
IUSE=""

ruby_add_rdepend '>=dev-ruby/text-format-0.64'
ruby_add_bdepend test 'dev-ruby/archive-tar-minitar'

all_ruby_prepare() {
	# Fix rakefile for new rake versions
	sed -i -e 's: if t\.verbose::' Rakefile || die
}
