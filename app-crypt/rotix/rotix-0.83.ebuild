# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/rotix/rotix-0.83.ebuild,v 1.15 2010/07/16 23:20:29 hwoarang Exp $

EAPI=2
inherit eutils

DESCRIPTION="Rotix allows you to generate rotational obfuscations."
HOMEPAGE="http://elektron.its.tudelft.nl/~hemmin98/rotix.html"
SRC_URI="http://elektron.its.tudelft.nl/~hemmin98/rotix_releases/${P}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ia64 ppc x86"
IUSE=""

DEPEND="sys-devel/gettext"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${PV}-respect-CFLAGS-and-dont-strip.patch
	epatch "${FILESDIR}"/${P}-locale.diff
}

src_configure() {
	econf --i18n=1
}

src_install() {
	emake DESTDIR="${D}" install || die
}
