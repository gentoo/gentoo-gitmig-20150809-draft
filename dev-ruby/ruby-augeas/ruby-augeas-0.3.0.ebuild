# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-augeas/ruby-augeas-0.3.0.ebuild,v 1.4 2010/09/20 20:00:17 gmsoft Exp $

inherit gems

DESCRIPTION="Ruby bindings for Augeas"
HOMEPAGE="http://augeas.net/"
SRC_URI="http://augeas.net/download/ruby/${P}.gem"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 hppa ~ppc sparc ~x86"
IUSE=""

DEPEND="app-admin/augeas"
RDEPEND="${DEPEND}"
