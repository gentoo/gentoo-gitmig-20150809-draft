# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/ode/ode-0.10.1.ebuild,v 1.1 2008/09/03 16:56:28 nyhm Exp $

DESCRIPTION="Open Dynamics Engine SDK"
HOMEPAGE="http://ode.org/"
SRC_URI="mirror://sourceforge/opende/${P}.tar.bz2"

LICENSE="|| ( LGPL-2.1 BSD )"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="debug double-precision gyroscopic"

DEPEND="virtual/opengl
	virtual/glu"

src_compile() {
	econf \
		--disable-dependency-tracking \
		--disable-demos \
		--enable-shared \
		$(use_enable debug asserts) \
		$(use_enable double-precision) \
		$(use_enable gyroscopic) \
		|| die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc CHANGELOG.txt README.txt
}
