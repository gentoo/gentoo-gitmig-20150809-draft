# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/yaps/yaps-0.96.ebuild,v 1.2 2005/07/29 10:41:25 dholm Exp $

inherit eutils

DESCRIPTION="Yet Another Pager Software (optional with CAPI support)"
HOMEPAGE="ftp://sunsite.unc.edu/pub/Linux/apps/serialcomm/machines/"
SRC_URI="capi? ( mirror://sourceforge/capi4yaps/${P}.c2.tgz )
	!capi? ( ftp://sunsite.unc.edu/pub/Linux/apps/serialcomm/machines/${P}.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="capi lua slang unicode"
DEPEND="capi? ( net-dialup/capi4k-utils )
	slang? ( sys-libs/slang )
	lua? ( dev-lang/lua )
	lua? ( dev-util/pkgconfig )"

use capi && S="${S}.c2"

src_unpack() {
	unpack ${A}
	cd ${S}

	# apply patches
	epatch ${FILESDIR}/${P}.patch
	use capi \
		&& grep 2>/dev/null -q CAPI_LIBRARY_V2 /usr/include/capiutils.h \
		&& epatch ${FILESDIR}/${P}-capiv3.patch

	# if specified, convert all relevant files from latin1 to UTF-8
	if use unicode; then
		for i in yaps.doc; do
			einfo "Converting '${i}' to UTF-8"
			iconv -f latin1 -t utf8 -o "${i}~" "${i}" && mv -f "${i}~" "${i}" || rm -f "${i}~"
		done
	fi
}

src_compile() {
	local myconf=""
	use lua && myconf="${myconf} LUA=True"
	use slang && myconf="${myconf} SLANG=True"
	emake CFLAGS="$CFLAGS" ${myconf} || die "emake failed"
}

src_install() {
	dobin yaps
	insinto /etc
	doins yaps.rc
	keepdir /usr/lib/yaps
	doman yaps.1
	dohtml yaps.html
	dodoc BUGREPORT COPYRIGHT INSTALL README yaps.lsm yaps.doc
	docinto contrib
	dodoc contrib/{README,m2y.pl,tap.sl}
}

pkg_postinst() {
	einfo
	einfo "Please edit /etc/yaps.rc to suit your needs."
	einfo
}
