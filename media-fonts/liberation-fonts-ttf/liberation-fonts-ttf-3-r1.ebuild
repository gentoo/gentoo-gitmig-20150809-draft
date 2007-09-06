# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/liberation-fonts-ttf/liberation-fonts-ttf-3-r1.ebuild,v 1.8 2007/09/06 14:07:45 angelos Exp $

inherit font

MY_PV="0.2"

DESCRIPTION="A GPL-2 Helvetica/Times/Courier replacement TrueType font set, courtesy of Red Hat"
SRC_URI="https://www.redhat.com/f/fonts/${P}.tar.gz"
HOMEPAGE="http://www.redhat.com/promo/fonts/"
KEYWORDS="amd64 ppc ppc64 ~x86 ~x86-fbsd"
SLOT="0"
LICENSE="GPL-2-with-exceptions"
IUSE="X"

FONT_PN="${PN/-ttf/}"
FONT_S="${WORKDIR}/${FONT_PN}-${MY_PV}"
S="${FONT_S}"

FONT_SUFFIX="ttf"
DOCS="License.txt"

FONT_CONF="${FILESDIR}"/60-liberation.conf

pkg_postinst() {
	font_pkg_postinst

	echo
	elog "To substitute Liberation fonts for Microsoft equivalents, use:"
	elog "  cd /etc/fonts/conf.d/ && ln -sf ../conf.avail/60-liberation.conf ."
	echo
}
