# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/glunarclock/glunarclock-0.32.1.ebuild,v 1.3 2004/09/02 22:49:40 pvdabeel Exp $

inherit gnome2

DESCRIPTION="Gnome Moon Phase Panel Applet"

HOMEPAGE="http://glunarclock.sourceforge.net/"
SRC_URI="mirror://sourceforge/glunarclock/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ppc"
IUSE=""

DEPEND=">=gnome-base/gnome-2.6.0"

DOCS="AUTHORS ChangeLog COPYING* INSTALL MAINTAINERS TODO README"
