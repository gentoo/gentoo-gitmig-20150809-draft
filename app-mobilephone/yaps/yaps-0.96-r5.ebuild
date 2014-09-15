# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/yaps/yaps-0.96-r5.ebuild,v 1.3 2014/09/15 08:48:46 jer Exp $

EAPI=5
inherit eutils toolchain-funcs

DESCRIPTION="Yet Another Pager Software (optional with CAPI support)"
HOMEPAGE="ftp://sunsite.unc.edu/pub/Linux/apps/serialcomm/machines/"
SRC_URI="capi? ( ftp://ftp.melware.net/capi4yaps/${P}.c4.tgz )
	!capi? ( ftp://sunsite.unc.edu/pub/Linux/apps/serialcomm/machines/${P}.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="+capi lua slang unicode"

RDEPEND="
	capi? ( net-dialup/capi4k-utils )
	slang? ( >=sys-libs/slang-1.4 )
	lua? ( dev-lang/lua )
	!media-sound/abcmidi
"
DEPEND="
	${RDEPEND}
	lua? ( virtual/pkgconfig )
"

if use capi; then
	S="${WORKDIR}"/${P}.c4
fi

src_prepare() {
	# apply patches
	epatch "${FILESDIR}/${P}-gentoo.diff"
	epatch "${FILESDIR}/${P}-getline-rename.patch"

	# fix compile warning
	if ! use capi; then
		epatch "${FILESDIR}"/${P}-string.patch
	fi

	# if specified, convert all relevant files from latin1 to UTF-8
	if use unicode; then
		for i in yaps.doc; do
			einfo "Converting '${i}' to UTF-8"
			iconv -f latin1 -t utf8 -o "${i}~" "${i}" && mv -f "${i}~" "${i}" || rm -f "${i}~"
		done
	fi
}

src_compile() {
	emake \
		$(usex lua LUA=true '') \
		$(usex slang SLANG=true '') \
		CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}" \
		CXX="$(tc-getCXX)"
}

src_install() {
	dobin yaps
	insinto /etc
	doins yaps.rc
	keepdir /usr/lib/yaps

	doman yaps.1
	dohtml yaps.html
	dodoc BUGREPORT COPYRIGHT README yaps.lsm yaps.doc
	newdoc contrib/README README.contrib

	insinto /usr/share/doc/${PF}/contrib
	doins contrib/{m2y.pl,tap.sl}
}
