# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/qalculate/qalculate-0.5.1.ebuild,v 1.1 2004/05/19 18:20:59 xtv Exp $

inherit gnome2

DESCRIPTION="cool scientific calculator / computer algebra system"
HOMEPAGE="http://qalculate.sourceforge.net/"

MY_P=${PN}-gtk-${PV}
SRC_URI="mirror://sourceforge/qalculate/${MY_P}.tar.gz"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86"

IUSE=""

DEPEND=">=x11-libs/gtk+-2.0.0 \
	>=gnome-base/libglade-2.0.0 \
	app-text/scrollkeeper \
	gnome-extra/yelp \
	>=gnome-base/libgnome-2.0.0 \
	media-gfx/gnuplot \
	dev-libs/cln"

S=${WORKDIR}/${MY_P}
