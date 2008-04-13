# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/hoe/hoe-1.5.1.ebuild,v 1.5 2008/04/13 13:03:41 corsair Exp $

inherit gems

DESCRIPTION="Hoe extends rake to provide full project automation."
HOMEPAGE="http://seattlerb.rubyforge.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~ia64 ppc ppc64 x86"
IUSE=""

DEPEND=">=dev-ruby/rake-0.8.1
	>=dev-ruby/rubyforge-0.4.4"
