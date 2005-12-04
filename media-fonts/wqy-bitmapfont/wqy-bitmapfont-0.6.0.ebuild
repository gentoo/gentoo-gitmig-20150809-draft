# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/wqy-bitmapfont/wqy-bitmapfont-0.6.0.ebuild,v 1.1 2005/12/04 04:14:16 usata Exp $

inherit font

DESCRIPTION="WenQuanYi Bitmap Song CJK font"
HOMEPAGE="http://wqy.sourceforget.net/en/"
SRC_URI="mirror://sourceforge/wqy/${PN}-pcf-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=""
S="${WORKDIR}/${PN}"
FONT_S="${S}"

FONT_SUFFIX="pcf"
DOCS="INSTALL* LATEST-IS* STAT README LOGO.PNG CREDIT ChangeLog"
