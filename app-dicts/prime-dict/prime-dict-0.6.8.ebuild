# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/prime-dict/prime-dict-0.6.8.ebuild,v 1.3 2004/03/27 15:56:00 usata Exp $

inherit ruby

IUSE=""

DESCRIPTION="Dictionary files for PRIME input method"
HOMEPAGE="http://taiyaki.org/prime/"
SRC_URI="http://prime.sourceforge.jp/src/${P/_/-}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"
SLOT="0"
S="${WORKDIR}/${P%_*}"

DEPEND="dev-lang/ruby"

EXTRA_ECONF="--with-rubydir=/usr/lib/ruby/site_ruby"
