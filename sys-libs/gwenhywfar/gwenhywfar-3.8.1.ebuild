# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/gwenhywfar/gwenhywfar-3.8.1.ebuild,v 1.2 2009/05/23 13:47:32 hanno Exp $

EAPI="2"

inherit autotools

DESCRIPTION="A multi-platform helper library for other libraries"
HOMEPAGE="http://gwenhywfar.sourceforge.net"
SRC_URI="http://www2.aquamaniac.de/sites/download/download.php?package=01&release=22&file=01&dummy=${P}.tar.gz -> ${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"

IUSE="debug ssl doc"

RDEPEND="ssl? ( net-libs/gnutls )"
DEPEND="${RDEPEND}
	>=sys-devel/libtool-2.2.4
	doc? ( app-doc/doxygen )"

src_prepare() {
	epatch "${FILESDIR}/gwenhywfar-3.8.1-asneeded.diff" || die "epatch failed"
	epatch "${FILESDIR}/gwenhywfar-3.8.1-gcc-check.diff" || die "epatch failed"
	epatch "${FILESDIR}/gwenhywfar-3.8.1-gnutls-check.diff" || die "epatch failed"
	eautoreconf || die
}

src_configure() {
	econf --enable-visibility \
		$(use_enable ssl) \
		$(use_enable debug) \
		$(use_enable doc full-doc) \
		--with-docpath="/usr/share/doc/${PF}/apidoc" || die "configure failed"
}

src_compile() {
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
