# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/tpm-tools/tpm-tools-1.1.0.ebuild,v 1.3 2007/06/26 01:34:29 mr_bones_ Exp $

inherit autotools

DESCRIPTION="TrouSerS' support tools for the Trusted Platform Modules"
HOMEPAGE="http://trousers.sf.net"
SRC_URI="mirror://sourceforge/trousers/${P}.tar.gz"
LICENSE="CPL-1.0"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="virtual/libc
	>=dev-libs/openssl-0.9.7
	>=app-crypt/trousers-0.1.1"
# TODO: add optionnal opencryptoki support

DEPEND="${RDEPEND}
	sys-devel/autoconf"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# workaround econf "updating config.sub" sandbox violation
	## (bug #96242 for instance):
	#touch config.sub

	# no translation so far -> no need to gettextize it
	# (makes compilation a bit simpler...):
	sed -i '/^gettextize/d' ./bootstrap.sh
	sed -i '/\<po\>/d' Makefile.am
	sed -i -e '/AM_GNU_GETTEXT/d' -e '\:po/Makefile.in:d' configure.in

	epatch "${FILESDIR}/${P}-as-needed.patch"

	eautoreconf
}

src_compile() {
	econf --disable-nls || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README
}
