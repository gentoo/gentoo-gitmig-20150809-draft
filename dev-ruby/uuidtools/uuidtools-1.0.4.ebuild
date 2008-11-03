# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/uuidtools/uuidtools-1.0.4.ebuild,v 1.3 2008/11/03 06:17:31 graaff Exp $

inherit gems

DESCRIPTION="Simple library to generate UUIDs"
HOMEPAGE="http://uuidtools.rubyforge.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-ruby/rspec-1.0.8"
DEPEND="${RDEPEND}"
