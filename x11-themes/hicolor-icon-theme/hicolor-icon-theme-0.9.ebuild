# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/hicolor-icon-theme/hicolor-icon-theme-0.9.ebuild,v 1.2 2006/07/05 06:00:57 vapier Exp $

DESCRIPTION="Fallback theme for the freedesktop icon theme specification"
HOMEPAGE="http://icon-theme.freedesktop.org/wiki/HicolorTheme"
SRC_URI="http://icon-theme.freedesktop.org/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86"
IUSE=""

DEPEND=""

src_install() {
	make DESTDIR="${D}" install || die

	dodoc ChangeLog README
}
