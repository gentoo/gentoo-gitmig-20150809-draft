# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-xslt/ruby-xslt-0.9.6.ebuild,v 1.2 2009/06/18 18:23:42 graaff Exp $

inherit ruby gems

DESCRIPTION="A Ruby class for processing XSLT"
HOMEPAGE="http://www.rubyfr.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc64 ~x86"
IUSE=""
USE_RUBY="ruby18"

DEPEND=">=dev-libs/libxslt-1.1.12"
