# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/prime-dict/prime-dict-0.8.7.ebuild,v 1.1 2005/03/21 17:20:48 usata Exp $

inherit ruby

DESCRIPTION="Dictionary files for PRIME input method"
HOMEPAGE="http://taiyaki.org/prime/"
SRC_URI="mirror://sourceforge.jp/prime/13191/${P/_/-}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~ppc ~x86 ~ppc64"
IUSE=""

S="${WORKDIR}/${P%_*}"

RUBY_ECONF="--with-rubydir=/usr/lib/ruby/site_ruby"
