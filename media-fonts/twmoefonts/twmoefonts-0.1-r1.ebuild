# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/twmoefonts/twmoefonts-0.1-r1.ebuild,v 1.13 2006/11/26 23:05:53 flameeyes Exp $

inherit font

IUSE=""

DESCRIPTION="Standard traditional Chinese fonts made by Minister of Education (MOE), Republic of China."
SRC_URI="ftp://ftp.ncu.edu.tw/FreeBSD/distfiles/zh-moettf/moe_kai.ttf
	ftp://ftp.ncu.edu.tw/FreeBSD/distfiles/zh-moettf/moe_sung.ttf"
HOMEPAGE="ftp://ftp.ncu.edu.tw/FreeBSD/distfiles/zh-moettf/"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ppc s390 sh sparc x86 ~x86-fbsd"

FONT_SUFFIX="ttf"

S="${WORKDIR}"
FONT_S="${S}"

# Only installs fonts
RESTRICT="strip binchecks"

src_unpack() {
	cp "${DISTDIR}/moe_kai.ttf" "${DISTDIR}/moe_sung.ttf" "${WORKDIR}"
}
