# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/dropbear/dropbear-0.44.ebuild,v 1.1 2005/01/11 20:04:35 vapier Exp $

DESCRIPTION="small SSH 2 client/server designed for small memory environments"
HOMEPAGE="http://matt.ucc.asn.au/dropbear/"
SRC_URI="http://matt.ucc.asn.au/dropbear/releases/${P}.tar.bz2
	http://matt.ucc.asn.au/dropbear/testing/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~sh ~x86"
IUSE="zlib multicall static"

RDEPEND="zlib? ( sys-libs/zlib )"
DEPEND="${RDEPEND}
	>=sys-apps/portage-2.0.51"

src_compile() {
	econf $(use_enable zlib) || die

	local makeopts=""
	use multicall && makeopts="${makeopts} MULTI=1"
	use static && makeopts="${makeopts} STATIC=1"
	emake ${makeopts} || die "make failed"
}

src_install() {
	local makeopts=""
	use multicall && makeopts="${makeopts} MULTI=1"
	use static && makeopts="${makeopts} STATIC=1"
	make install DESTDIR="${D}" || die "make install failed"
	newinitd ${FILESDIR}/dropbear.init.d dropbear
	newconfd ${FILESDIR}/dropbear.conf.d dropbear
	dodoc CHANGES README TODO SMALL MULTI

	# The multi install target installs same binary
	# multiple times ... lets clean that up
	if use multicall ; then
		cd "${D}"/usr/bin
		local x
		for x in * ; do
			dosym ../sbin/dropbear /usr/bin/${x}
		done
		cd "${S}"
	fi
}
