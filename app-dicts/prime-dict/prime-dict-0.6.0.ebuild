# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/prime-dict/prime-dict-0.6.0.ebuild,v 1.2 2003/12/24 22:43:41 usata Exp $

inherit ruby

IUSE=""

DESCRIPTION="Dictionary files for PRIME input method"
HOMEPAGE="http://taiyaki.org/prime/"
SRC_URI="http://prime.sourceforge.jp/src/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"
S="${WORKDIR}/${P}"

DEPEND="dev-lang/ruby"

EXTRA_ECONF="--with-rubydir=/usr/lib/ruby/site_ruby"
