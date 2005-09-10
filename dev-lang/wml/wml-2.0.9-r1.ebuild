# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/wml/wml-2.0.9-r1.ebuild,v 1.1 2005/09/10 06:51:30 vapier Exp $

inherit fixheadtails eutils

DESCRIPTION="Website META Language"
HOMEPAGE="http://www.engelschall.com/sw/wml/"
SRC_URI="http://www.engelschall.com/sw/wml/distrib/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~s390 ~sparc ~x86"
IUSE=""

RDEPEND="dev-libs/libpcre
	dev-lang/perl"
DEPEND="${RDEPEND}
	>=sys-devel/autoconf-2.58"

src_unpack() {
	unpack ${A}
	ht_fix_all
	cd "${S}"
	epatch "${FILESDIR}"/${P}-autotools-update.patch
	export WANT_AUTOCONF='2.5'
	for d in $(find "${S}" -mindepth 2 -name configure -printf '%h ') ; do
		cd "${d}"
		autoconf || die "autoconf in ${d}"
	done
	(cd "${S}"/wml_backend/p2_mp4h && automake) || die "automake failed in wml_backend/p2_mp4h"
}

src_compile() {
	econf --libdir=/usr/lib/wml || die "./configure failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die
	dodoc ANNOUNCE BUGREPORT C* INSTALL MANIFEST README* SUPPORT VERSION*
}
