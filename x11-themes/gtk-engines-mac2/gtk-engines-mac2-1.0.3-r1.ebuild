# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-mac2/gtk-engines-mac2-1.0.3-r1.ebuild,v 1.1 2003/06/19 09:47:17 liquidx Exp $

inherit gtk-engines2

IUSE=""
DESCRIPTION="GTK+1 MacOS Look-alike Theme Engine"
HOMEPAGE="http://themes.freshmeat.net/projects/mac2/"
SRC_URI="http://download.freshmeat.net/themes/mac2/mac2-1.2.x.tar.gz"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
LICENSE="GPL-2"
SLOT="1"

DEPEND="=x11-libs/gtk+-1.2*"

S=${WORKDIR}/gtk-Mac2-theme


