# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-lighthouseblue/gtk-engines-lighthouseblue-0.7.0.ebuild,v 1.5 2004/01/10 14:03:29 gustavoz Exp $

inherit gtk-engines2

GTK1_VER="0.6.3"
GTK2_VER="${PV}"

IUSE=""
DESCRIPTION="GTK+1 and GTK+2 Lighthouseblue Theme Engine"
HOMEPAGE="http://lighthouseblue.sf.net/"
SRC_URI="mirror://sourceforge/lighthouseblue/lighthouseblue-gtk1-${GTK1_VER}.tar.gz
	mirror://sourceforge/lighthouseblue/lighthouseblue-gtk2-${GTK2_VER}.tar.gz"

KEYWORDS="x86 ~ppc ~alpha sparc hppa"
LICENSE="GPL-2"
SLOT="2"

# if we have gnome-themes, then we only install the GTK+1 version
if has_version "x11-themes/gnome-themes"; then
	S=${WORKDIR}/lighthouseblue-gtk1
else
	GTK1_S=${WORKDIR}/lighthouseblue-gtk1
	GTK2_S=${WORKDIR}/lighthouseblue-gtk2
fi
