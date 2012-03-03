# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/pftpfxp/pftpfxp-1.12.ebuild,v 1.1 2012/03/03 19:38:45 pacho Exp $

EAPI=4
inherit eutils toolchain-funcs

MY_P=pftp-shit.v.${PV}

DESCRIPTION="The powerful curses-based ftp/fxp client, shit edition"
HOMEPAGE="http://www.geekspot.nl/?page_id=6"
SRC_URI="http://www.geekspot.nl/wp-content/uploads/2011/03/${MY_P}.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE="ssl"

DEPEND="app-arch/unzip
	ssl? ( >=dev-libs/openssl-0.9.6c )"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "$FILESDIR/1.11-gcc43.patch"
}

src_configure() {
	#fix permissions of configure script
	chmod +x configure
	# no stripping
	sed -i -e 's/[^D]*DO.*//g' configure
	sed -i -e 's/CPP/CXX/g' src/Makefile.in
	#note: not a propper autoconf
	./configure || die "configure failed"
	sed -i -e 's:$<:$(CPPFLAGS) $<:' -e 's/LINKFLAGS/LDFLAGS/g'  src/Makefile
}

src_compile() {
	tc-export CXX
	emake
}

src_install() {
	dobin pftp
	dodoc .pftp/config .pftp/keymap README.MEW old/*
}

pkg_postinst() {
	einfo "In order to use pftp-shit you need to create these files:"
	einfo "    ~/.pftp/config"
	einfo "    ~/.pftp/keymap"
	einfo "Refer to the examples in /usr/share/doc/${PF} for more information."
}
