# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-augeas/ruby-augeas-0.2.0.ebuild,v 1.2 2009/03/24 23:22:50 josejx Exp $

inherit gems

DESCRIPTION="Ruby bindings for Augeas"
HOMEPAGE="http://augeas.net/"
SRC_URI="http://augeas.net/download/ruby/${P}.gem"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="app-admin/augeas"
RDEPEND="${DEPEND}"
