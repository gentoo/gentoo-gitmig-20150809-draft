# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jens Blaesche <mr.big@pc-trouble.de>
# 30 Sept.2001 / 0.30 CET

#P=
S=${WORKDIR}/${P}
A=${P}.tar.gz

DESCRIPTION="gLabels is a lightweight program for creating labels and business cards for the GNOME desktop environment."

SRC_URI="http://snaught.com/glabels/source/${A}"

HOMEPAGE="http://snaught.com/glabels/"

DEPEND=">=media-libs/gdk-pixbuf-0.11
	>=gnome-base/gnome-print-0.25
	>=dev-libs/libxml-1.8.0
	>=x11-libs/gtk+-1.2.0
	"

RDEPEND=""

src_compile() {
	./configure --prefix=/usr --host=${CHOST} || die
	make || die
}

src_install () {
	try make prefix=${D}/usr install
	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}

