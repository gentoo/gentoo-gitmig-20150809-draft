# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/dictd-wn/dictd-wn-2.0.ebuild,v 1.7 2006/05/12 21:05:56 arj Exp $

inherit gnuconfig

MY_P=${P/td/t}
DESCRIPTION="WordNet for dict"
HOMEPAGE="http://www.dict.org/"
SRC_URI="ftp://ftp.dict.org/pub/dict/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~x86 ~ppc ~sparc ~amd64" #  ~ppc64 removed due to errors

DEPEND=">=app-text/dictd-1.5.5"

S=${WORKDIR}/${MY_P}

src_compile() {
	gnuconfig_update
	# don't use econf, configure script is broken
	./configure || die "configure failed"
	emake || die "compile failed"
	emake db || die "compile database failed"
}

src_install() {
	cd ${S}
	insinto /usr/lib/dict
	doins wn.dict.dz wn.index || die
}
