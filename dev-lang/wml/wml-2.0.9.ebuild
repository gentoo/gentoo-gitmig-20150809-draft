# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/wml/wml-2.0.9.ebuild,v 1.20 2005/05/04 12:59:00 herbs Exp $

inherit fixheadtails eutils

DESCRIPTION="Website META Language"
HOMEPAGE="http://www.engelschall.com/sw/wml/"
SRC_URI="http://www.engelschall.com/sw/wml/distrib/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc s390 ppc ~amd64"
IUSE=""
DEPEND="dev-lang/perl
	>=sys-devel/autoconf-2.58
	sys-apps/gawk
	sys-apps/grep
	sys-devel/bison
	sys-devel/gcc
	virtual/libc
	sys-devel/gettext"

RDEPEND="virtual/libc
	sys-devel/gettext"

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
	econf --libdir=/usr/lib/wml || die "./configure failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die
	dodoc ANNOUNCE BUGREPORT C* INSTALL MANIFEST README* SUPPORT VERSION*
}
