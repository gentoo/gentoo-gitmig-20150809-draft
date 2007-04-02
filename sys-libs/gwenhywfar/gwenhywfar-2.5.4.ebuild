# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/gwenhywfar/gwenhywfar-2.5.4.ebuild,v 1.1 2007/04/02 23:12:54 hanno Exp $

DESCRIPTION="A multi-platform helper library for other libraries"
HOMEPAGE="http://gwenhywfar.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"

IUSE="debug ssl doc ncurses"

DEPEND="ssl? ( >=dev-libs/openssl-0.9.6b )
	sys-libs/ncurses
	doc? ( app-doc/doxygen )
	ncurses? ( sys-libs/ncurses )"

src_compile() {
	econf \
		$(use_enable ssl) \
		$(use_enable debug) \
		$(use_enable doc full-doc) \
		$(use_enable ncurses gwenui) \
		--with-docpath=/usr/share/doc/${PF}/apidoc || die "configure failed"
	emake || die "emake failed"
	if use doc ; then
		emake srcdoc || die "emake failed"
	fi
}

src_install() {
	einstall || die
	dodoc README* AUTHORS ChangeLog TODO
	if use doc ; then
		make DESTDIR="${D}" install-srcdoc || die "make isntall-srcdoc failed"
	fi
}
