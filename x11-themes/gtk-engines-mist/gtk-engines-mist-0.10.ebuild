# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-mist/gtk-engines-mist-0.10.ebuild,v 1.1 2003/06/19 09:48:44 liquidx Exp $

inherit gtk-engines2

MY_P="${P/engines-mist/mist-engine}"

IUSE=""
DESCRIPTION="GTK+2 Mist Theme Engine"
HOMEPAGE="http://primates.ximian.com/~dave/mist/"
SRC_URI="http://primates.ximian.com/~dave/mist/${MY_P}.tar.gz"
KEYWORDS="~x86 ~ppc ~alpha ~sparc"
LICENSE="GPL-2"
SLOT="2"

DEPEND=">=x11-libs/gtk+-2
	!x11-themes/gnome-themes"

S=${WORKDIR}/${MY_P}

