# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/prime-dict/prime-dict-0.8.3.ebuild,v 1.4 2004/09/23 23:51:35 vapier Exp $

inherit ruby

DESCRIPTION="Dictionary files for PRIME input method"
HOMEPAGE="http://taiyaki.org/prime/"
SRC_URI="http://prime.sourceforge.jp/src/${P/_/-}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ppc x86"
IUSE=""

DEPEND="virtual/ruby"

S="${WORKDIR}/${P%_*}"

RUBY_ECONF="--with-rubydir=/usr/lib/ruby/site_ruby"
