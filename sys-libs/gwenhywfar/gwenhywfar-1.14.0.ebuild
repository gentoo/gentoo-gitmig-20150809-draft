# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/gwenhywfar/gwenhywfar-1.14.0.ebuild,v 1.2 2005/08/26 18:38:56 agriffis Exp $

DESCRIPTION="A multi-platform helper library for other libraries"
HOMEPAGE="http://gwenhywfar.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"

IUSE="debug ssl doc"

DEPEND="ssl? ( >=dev-libs/openssl-0.9.6b )
		sys-libs/ncurses
		doc? ( app-doc/doxygen )"

src_compile() {
	if use doc; then
		APIDOC="--with-docpath=/usr/share/doc/${P}/apidoc"
	fi
	econf \
	`use_enable ssl` \
	`use_enable debug` \
	`use_enable doc full-doc` \
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
