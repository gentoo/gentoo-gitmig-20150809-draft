# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/gnome-speech/gnome-speech-0.2.7.ebuild,v 1.1 2004/03/17 22:15:32 leonardop Exp $

inherit gnome2

DESCRIPTION="Simple general API for producing text-to-speech output"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2"
SLOT="1"
KEYWORDS="x86"

IUSE=""

# FIXME: This package depends on bonobo-activation, which is included in
# recent versions of libbonobo. However, if one were to use slightly older
# versions of these packages, we would have to rely on
# gnome-base/bonobo-activation.
RDEPEND=">=gnome-base/libbonobo-1.97
	>=gnome-base/ORBit2-2.3.94"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog COPYING NEWS README"

# The Java support for this package seems to be somewhat brain-damaged,
# and although it would be nice to implement it via the "java" USE flag,
# we will have to disable it entirely for now.
export JAVAC=no
