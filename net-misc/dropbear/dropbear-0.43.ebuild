# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/dropbear/dropbear-0.43.ebuild,v 1.5 2005/01/11 18:05:40 gustavoz Exp $

inherit gnuconfig

DESCRIPTION="small SSH 2 server designed for small memory environments"
HOMEPAGE="http://matt.ucc.asn.au/dropbear/"
SRC_URI="http://matt.ucc.asn.au/dropbear/releases/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc sh x86 sparc"
IUSE="zlib multicall static"

DEPEND="zlib? ( sys-libs/zlib )"

src_unpack() {
	unpack ${A}
	cd ${S}
	gnuconfig_update
}

src_compile() {
	econf `use_enable zlib` || die

	local maketarget=""
	if use multicall ; then
		sed -i \
			-e '/define DROPBEAR_MULTI/s:/\* *::' \
			-e '/define DROPBEAR_MULTI/s:\*/::' \
			options.h
		use static \
			&& maketarget="dropbearmultistatic" \
			|| maketarget="dropbearmulti"
	else
		use static && maketarget="static"
	fi
	emake ${maketarget} || die "make ${maketarget} failed"
}

src_install() {
	if use multicall ; then
		local multibin="dropbearmulti"
		use static && multibin="static${multibin}"
		dodir /usr/bin /usr/sbin
		dobin ${multibin} || die "dropbearmulti"
		dosym ${multibin} /usr/bin/dropbearkey || die
		dosym ${multibin} /usr/bin/dropbearconvert || die
		dosym ../bin/${multibin} /usr/sbin/dropbear || die
	else
		local maketarget="install"
		use static && maketarget="install-static"
		make ${maketarget} DESTDIR=${D} || die "make ${maketarget} failed"
	fi
	exeinto /etc/init.d ; newexe ${FILESDIR}/dropbear.init.d dropbear
	insinto /etc/conf.d ; newins ${FILESDIR}/dropbear.conf.d dropbear
	dodoc CHANGES README TODO SMALL
}
