# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/enca/enca-1.9-r1.ebuild,v 1.2 2009/03/01 17:11:23 loki_val Exp $

DESCRIPTION="ENCA detects the character coding of a file and converts it if desired"
HOMEPAGE="http://trific.ath.cx/software/enca/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="doc"

DEPEND="app-text/recode"
RDEPEND="${DEPEND}"

src_compile() {
	econf \
		--with-librecode=/usr \
		--enable-external \
		$(use_enable doc gtk-doc) \
		|| die "configure failed"

	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die
}
