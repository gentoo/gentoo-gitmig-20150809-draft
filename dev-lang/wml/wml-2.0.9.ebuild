# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/wml/wml-2.0.9.ebuild,v 1.9 2004/01/30 05:26:53 drobbins Exp $

inherit fixheadtails

DESCRIPTION="Website META Language"
HOMEPAGE="http://www.engelschall.com/sw/wml/"
SRC_URI="http://www.engelschall.com/sw/wml/distrib/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc"

DEPEND="dev-lang/perl >=sys-devel/autoconf-2.58"

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
	if has_version '<sys-devel/autoconf-2.58' ; then
		unset CC
		unset CFLAGS
	fi
	econf || die "./configure failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die
	dodoc ANNOUNCE BUGREPORT C* INSTALL MANIFEST README* SUPPORT VERSION*
}
