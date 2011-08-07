# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/jabber4r/jabber4r-0.8.0-r1.ebuild,v 1.3 2011/08/07 07:05:42 graaff Exp $

EAPI=2
USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_TEST=""
RUBY_FAKEGEM_DOCDIR="html"
RUBY_FAKEGEM_EXTRADOC="CHANGES README"

inherit ruby-fakegem

DESCRIPTION="A Jabber library in pure Ruby"
HOMEPAGE="http://jabber4r.rubyforge.org/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ia64 ~ppc64 x86"
IUSE=""
