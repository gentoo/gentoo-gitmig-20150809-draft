# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/wqy-bitmapfont/wqy-bitmapfont-0.9.9_p0.ebuild,v 1.1 2007/12/01 16:57:51 matsuu Exp $

inherit font

DESCRIPTION="WenQuanYi Bitmap Song CJK font"
HOMEPAGE="http://wqy.sourceforge.net/en/"
SRC_URI="mirror://sourceforge/wqy/${PN}-pcf-${PV/_p/-}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~ppc ~s390 ~sh ~x86 ~x86-fbsd"
IUSE=""

DEPEND=""

S="${WORKDIR}/${PN}"
FONT_S="${S}"
FONT_CONF="85-wqy-bitmapsong.conf"

FONT_SUFFIX="pcf"
DOCS="AUTHORS ChangeLog Logo.PNG README"

# Only installs fonts
RESTRICT="strip binchecks"
