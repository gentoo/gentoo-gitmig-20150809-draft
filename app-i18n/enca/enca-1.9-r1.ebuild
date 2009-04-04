# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/enca/enca-1.9-r1.ebuild,v 1.11 2009/04/04 18:23:44 solar Exp $

DESCRIPTION="ENCA detects the character coding of a file and converts it if desired"
HOMEPAGE="http://trific.ath.cx/software/enca/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~arm alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="doc"

DEPEND=">=app-text/recode-3.6_p15"
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
