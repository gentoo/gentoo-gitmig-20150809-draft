# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/wml/wml-2.0.9.ebuild,v 1.7 2003/11/13 21:48:46 vapier Exp $

inherit fixheadtails

DESCRIPTION="Website META Language"
HOMEPAGE="http://www.engelschall.com/sw/wml/"
SRC_URI="http://www.engelschall.com/sw/wml/distrib/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc"

DEPEND="dev-lang/perl"

src_unpack() {
	unpack ${A}
	ht_fix_all
	cd ${S}
	epatch ${FILESDIR}/${PV}-fix-configure.in.patch
	export WANT_AUTOCONF='2.5'
	for d in `find ${S} -name configure -mindepth 2 -printf '%h '` ; do
		cd ${d}
		autoconf || die "autoconf in ${d}"
	done
}

src_compile() {
	econf || die "./configure failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die
	dodoc ANNOUNCE BUGREPORT C* INSTALL MANIFEST README* SUPPORT VERSION*
}
