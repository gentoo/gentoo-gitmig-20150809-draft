# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/tntnet/tntnet-1.6.3.ebuild,v 1.5 2009/05/30 20:21:07 arfrever Exp $

inherit autotools eutils

DESCRIPTION="A modular, multithreaded webapplicationserver extensible with C++."
HOMEPAGE="http://www.tntnet.org/index.hms"
SRC_URI="http://www.tntnet.org/download/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE="ssl gnutls examples"

RDEPEND="dev-libs/cxxtools
	sys-libs/zlib
	ssl? (
		gnutls? ( >=net-libs/gnutls-1.2.0 )
		!gnutls? ( dev-libs/openssl )
	)"
DEPEND="${RDEPEND}
	app-arch/zip
	ssl? ( gnutls? ( dev-util/pkgconfig ) )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-gcc43.patch"
	epatch "${FILESDIR}/${P}-gnutls-2.8.patch"

	eautoreconf
}

src_compile() {
	local myconf=""
	if use ssl; then
		if use gnutls; then
			einfo "Using gnutls for ssl support."
			myconf="${myconf} --with-ssl=gnutls"
		else
			einfo "Using openssl for ssl support."
			myconf="${myconf} --with-ssl=openssl"
		fi
	else
		einfo "Disabled ssl"
		myconf="${myconf} --with-ssl=no"
	fi
	if use examples; then
		myconf="${myconf} --with-demos=yes"
	else
		myconf="${myconf} --with-demos=no"
	fi

	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	dodoc AUTHORS ChangeLog README TODO doc/*.pdf

	if use examples; then
		cd "${S}/sdk/demos"
		make clean
		rm -rf .deps */.deps .libs */.libs

		local dir="/usr/share/doc/${PF}/examples"
		dodir "${dir}"
		cp -r "${S}"/sdk/demos/* "${D}${dir}"
	fi
}
