# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tcpdump/tcpdump-3.9.4.ebuild,v 1.9 2006/04/23 17:30:05 kumba Exp $

inherit flag-o-matic toolchain-funcs eutils

DESCRIPTION="A Tool for network monitoring and data acquisition"
HOMEPAGE="http://www.tcpdump.org/"
SRC_URI="http://www.tcpdump.org/release/${P}.tar.gz
	http://www.jp.tcpdump.org/release/${P}.tar.gz"
	#mirror://sourceforge/tcpdump/${P}.tar.gz

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc x86"
IUSE="ssl ipv6"

DEPEND="net-libs/libpcap
	ssl? ( >=dev-libs/openssl-0.9.6m )"

src_unpack() {
	unpack ${A}

	if use ssl ; then
		sed -i -e 's|des\(_cbc_encrypt\)|DES\1|' "${S}"/configure || \
			die "sed configure failed"
	fi
}

src_compile() {
	# tcpdump needs some optymalization. see bug #108391
	( ! is-flag -O? || is-flag -O0 ) && append-flags -O

	replace-flags -O[3-9] -O2
	filter-flags -finline-functions

	if [[ $(gcc-major-version) -gt 3 ]] || \
		[[ $(gcc-major-version) -eq 3 && $(gcc-minor-version) -ge 4 ]]
	then
		filter-flags -funit-at-a-time
		append-flags -fno-unit-at-a-time #48747
	fi

	local myconf
	use ssl || myconf="${myconf} --without-crypto"
	econf $(use_enable ipv6) ${myconf} || die
	make CCOPT="$CFLAGS" || die
}

src_install() {
	dosbin tcpdump || die
	doman tcpdump.1
	dodoc *.awk
	dodoc README FILES VERSION CHANGES
}
