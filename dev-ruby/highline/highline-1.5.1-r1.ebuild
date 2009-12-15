# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/highline/highline-1.5.1-r1.ebuild,v 1.1 2009/12/15 16:53:30 flameeyes Exp $

EAPI=2

USE_RUBY="ruby18 ruby19 jruby"

FAKEGEM_EXTRA_DOCS="CHANGELOG README TODO"

inherit ruby-fakegem

DESCRIPTION="Highline is a high-level command-line IO library for ruby."
HOMEPAGE="http://rubyforge.org/projects/highline/"

IUSE=""
LICENSE="|| ( GPL-2 Ruby )"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~x86"
