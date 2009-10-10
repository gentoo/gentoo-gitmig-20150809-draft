# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-augeas/ruby-augeas-0.3.0.ebuild,v 1.2 2009/10/10 14:57:59 armin76 Exp $

inherit gems

DESCRIPTION="Ruby bindings for Augeas"
HOMEPAGE="http://augeas.net/"
SRC_URI="http://augeas.net/download/ruby/${P}.gem"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc sparc ~x86"
IUSE=""

DEPEND="app-admin/augeas"
RDEPEND="${DEPEND}"
