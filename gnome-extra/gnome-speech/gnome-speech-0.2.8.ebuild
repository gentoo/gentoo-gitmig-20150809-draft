# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-speech/gnome-speech-0.2.8.ebuild,v 1.6 2004/02/06 00:30:34 lu_zero Exp $

inherit gnome2

DESCRIPTION="Simple general API for producing text-to-speech output"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2"
SLOT="1"
KEYWORDS="x86 sparc hppa alpha ia64 ~ppc"

IUSE=""

RDEPEND=">=gnome-base/libbonobo-2
	>=gnome-base/ORBit2-2.4"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog COPYING NEWS README"

# The Java support for this package seems to be somewhat brain-damaged,
# and although it would be nice to implement it via the "java" USE flag,
# we will have to disable it entirely for now.
export JAVAC=no
