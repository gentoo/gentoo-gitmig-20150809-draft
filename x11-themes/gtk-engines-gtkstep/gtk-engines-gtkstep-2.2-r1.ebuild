# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-gtkstep/gtk-engines-gtkstep-2.2-r1.ebuild,v 1.3 2004/01/12 15:49:41 gustavoz Exp $

inherit gtk-engines2

IUSE=""
DESCRIPTION="GTK+1 GTKStep Theme Engine"
HOMEPAGE="http://art.gnome.org/show_theme.php?themeID=250&category=gtk"
SRC_URI="mirror://gnome/teams/art.gnome.org/themes/gtk/GTK-Step-1.2.x.tar.gz"
KEYWORDS="x86 ~ppc sparc ~alpha"
LICENSE="GPL-2"
SLOT="1"

DEPEND="=x11-libs/gtk+-1.2*"

S=${WORKDIR}/${PN/gtk-engines-}-2.0


