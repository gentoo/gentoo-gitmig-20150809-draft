# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/gwenhywfar/gwenhywfar-3.11.3.ebuild,v 1.1 2010/01/07 10:12:26 ssuominen Exp $

EAPI=2

DESCRIPTION="A multi-platform helper library for other libraries"
HOMEPAGE="http://www.aquamaniac.de/aqbanking/"
SRC_URI="http://www.aquamaniac.de/sites/download/download.php?package=01&release=31&file=01&dummy=${P}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug ssl doc"

RDEPEND="ssl? ( net-libs/gnutls )"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_enable ssl) \
		--enable-visibility \
		$(use_enable debug) \
		$(use_enable doc full-doc) \
		--with-docpath=/usr/share/doc/${PF}/apidoc
}

src_compile() {
	emake || die

	if use doc; then
		emake srcdoc || die
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README TODO

	if use doc; then
		emake DESTDIR="${D}" install-srcdoc || die
	fi

	find "${D}" -name '*.la' -delete
}
