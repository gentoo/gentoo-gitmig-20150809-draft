# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/crack/crack-0.1.4-r1.ebuild,v 1.1 2010/01/11 12:21:57 a3li Exp $

EAPI="2"

USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_DOCDIR="rdoc"
RUBY_FAKEGEM_EXTRADOC="README.rdoc History"

inherit ruby-fakegem

# Needs jnunemaker-matchy, not tagged nor ever released.
RESTRICT="test"

DESCRIPTION="Really simple JSON and XML parsing, ripped from Merb and Rails."
HOMEPAGE="http://rubyforge.org/projects/crack"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
