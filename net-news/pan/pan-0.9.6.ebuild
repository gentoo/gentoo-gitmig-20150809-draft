# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Erik Van Reeth <erik@vanreeth.org>

#P=pan-0.9.6
A=pan-0.9.6.tar.bz2
S=${WORKDIR}/pan-0.9.6
DESCRIPTION="A newsreader for GNOME."
SRC_URI="http://pan.rebelbase.com/download/0.9.6/${A}"
HOMEPAGE="http://pan.rebelbase.com/"

DEPEND="virtual/x11
	>=gnome-base/gnome-libs-1.0.16"

src_compile() {

	try ./configure --prefix=/opt/gnome
	try make clean
	try make ${MAKEOPTS}

}

src_install () {

	try make prefix=${D}/opt/gnome install
	dodoc AUTHORS COPYING Changelog NEWS README TODO

}

