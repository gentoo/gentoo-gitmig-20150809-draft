# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/gnome-speech/gnome-speech-0.2.8.ebuild,v 1.4 2004/08/21 15:14:08 foser Exp $

inherit gnome2

DESCRIPTION="Simple general API for producing text-to-speech output"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2"
SLOT="1"
KEYWORDS="x86 ppc sparc alpha hppa ~amd64 ia64"
IUSE=""

RDEPEND=">=gnome-base/libbonobo-2
	>=gnome-base/orbit-2.4"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README"

# The Java support for this package seems to be somewhat brain-damaged,
# and although it would be nice to implement it via the "java" USE flag,
# we will have to disable it entirely for now.
export JAVAC=no
