# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/gwenhywfar/gwenhywfar-3.7.2.ebuild,v 1.2 2009/10/04 14:28:27 ssuominen Exp $

inherit flag-o-matic

RESTRICT="test"

DESCRIPTION="A multi-platform helper library for other libraries"
HOMEPAGE="http://gwenhywfar.sourceforge.net"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"

IUSE="debug ssl doc ncurses"

RDEPEND="ssl? ( net-libs/gnutls )
	sys-libs/ncurses
	ncurses? ( sys-libs/ncurses )"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

src_compile() {
	append-ldflags $(no-as-needed)
	econf \
		$(use_enable ssl) \
		$(use_enable debug) \
		$(use_enable doc full-doc) \
		$(use_enable ncurses gwenui) \
		--with-docpath="/usr/share/doc/${PF}/apidoc" || die "configure failed"
	emake || die "emake failed"
	if use doc ; then
		emake srcdoc || die "emake failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc README* AUTHORS ChangeLog TODO || die "dodoc failed"
	if use doc ; then
		make DESTDIR="${D}" install-srcdoc || die "install doc failed"
	fi
	find "${D}" -name '*.la' -delete
}
