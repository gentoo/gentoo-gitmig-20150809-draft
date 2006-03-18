# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tcpdump/tcpdump-3.8.3-r5.ebuild,v 1.1 2006/03/18 00:11:43 jokey Exp $

inherit flag-o-matic toolchain-funcs eutils

DESCRIPTION="A Tool for network monitoring and data acquisition"
HOMEPAGE="http://www.tcpdump.org/"
SRC_URI="mirror://sourceforge/tcpdump/${P}.tar.gz
	http://www.tcpdump.org/release/${P}.tar.gz
	http://www.jp.tcpdump.org/release/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="ssl ipv6 samba"

DEPEND="net-libs/libpcap
	ssl? ( >=dev-libs/openssl-0.9.6m )"

pkg_setup() {
	if use samba ; then
		ewarn
		ewarn "CAUTION !!! CAUTION !!! CAUTION"
		ewarn
		ewarn "You're about to compile tcpdump with samba printing support"
		ewarn "Upstream tags it as 'possibly-buggy SMB printer'"
		ewarn "So think twice whether this is fine with you"
		ewarn
		ewarn "CAUTION !!! CAUTION !!! CAUTION"
		ewarn
		ewarn "(Giving you 10 secs to think about it)"
		ewarn
		ebeep 5
		epause 5
	fi
}

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}/${P}-gentoo.patch"
	epatch "${FILESDIR}/${P}-gcc4.patch"
	epatch "${FILESDIR}/${P}-bgp-infinite-loop2.patch"

	if use ssl ; then
		sed -i -e 's|des\(_cbc_encrypt\)|DES\1|' "${S}"/configure || \
			die "sed configure failed"
	fi
}

src_compile() {
	replace-flags -O[3-9] -O2
	filter-flags -finline-functions

	# Fix wrt bug #48747
	if [[ $(gcc-major-version) -gt 3 ]] || \
		[[ $(gcc-major-version) -eq 3 && $(gcc-minor-version) -ge 4 ]]
	then
		filter-flags -funit-at-a-time
		append-flags -fno-unit-at-a-time
	fi

	local myconf
	if use ssl ; then
		myconf="--without-crypto"
	fi

	econf \
		$(use_enable ipv6) \
		$(use_with samba smb) \
		${myconf} || die "configure failed"

	make CCOPT="$CFLAGS" || die "make failed"
}

src_install() {
	dosbin tcpdump || die
	doman tcpdump.1
	dodoc *.awk
	dodoc README FILES VERSION CHANGES
}
