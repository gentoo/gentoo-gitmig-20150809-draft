# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/giggle/giggle-0.2.ebuild,v 1.3 2007/05/16 20:17:16 josejx Exp $

inherit gnome2

DESCRIPTION="GTK+ Frontend for GIT"
HOMEPAGE="http://developer.imendio.com/projects/giggle"
SRC_URI="http://ftp.imendio.com/pub/imendio/${PN}/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=dev-util/git-1.4.4.3
		 >=dev-libs/glib-2.12
		 >=x11-libs/gtk+-2.10
		 >=x11-libs/gtksourceview-1.8
		 >=gnome-base/libglade-2.4"
DEPEND="${RDEPEND}
		>=dev-util/pkgconfig-0.15"
