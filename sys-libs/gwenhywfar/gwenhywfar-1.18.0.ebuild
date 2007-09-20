# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/gwenhywfar/gwenhywfar-1.18.0.ebuild,v 1.7 2007/09/20 14:33:55 armin76 Exp $

DESCRIPTION="A multi-platform helper library for other libraries"
HOMEPAGE="http://gwenhywfar.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"

IUSE="debug ssl doc ncurses"

DEPEND="ssl? ( >=dev-libs/openssl-0.9.6b )
		sys-libs/ncurses
		doc? ( app-doc/doxygen )
		ncurses? ( sys-libs/ncurses )"

src_compile() {
	if use doc; then
		APIDOC="--with-docpath=/usr/share/doc/${P}/apidoc"
	fi
	econf \
	`use_enable ssl` \
	`use_enable debug` \
	`use_enable doc full-doc` \
	`use_enable ncurses gwenui` \
	${APIDOC} || die "configure failed"
	emake || die "emake failed"
	if use doc; then
		emake srcdoc || die "Building the api-doc failed"
	fi
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README* AUTHORS ABOUT-NLS COPYING ChangeLog INSTALL TODO
	if use doc; then
	make DESTDIR=${D} install-srcdoc || die "Installing the API-Doc failed"
	fi
}
