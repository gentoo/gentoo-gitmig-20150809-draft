# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Desktop Team <desktop@gentoo.org>
# Author: Jens Blaesche <mr.big@pc-trouble.de>
# $Header: /var/cvsroot/gentoo-x86/media-video/zapping/zapping-0.6.1.ebuild,v 1.1 2001/10/02 08:54:30 hallski Exp $

A="${P}.tar.gz"
S=${WORKDIR}/${P}
DESCRIPTION="Zapping is a TV- and VBI- viewer for the Gnome environment."
SRC_URI="http://prdownloads.sourceforge.net/zapping/${A}"
HOMEPAGE="http://zapping.sourceforge.net"

DEPEND=">=gnome-base/gnome-libs-1.2.0
	>=gnome-base/libglade-0.16
	>=x11-libs/gtk+-1.2.0"

src_compile() {
	./configure --prefix=/opt/gnome --infodir=/usr/share/info 	\
		    --mandir=/usr/share/man --host=${CHOST} || die

	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	rm ${D}/opt/gnome/bin/zapzilla
	dosym /opt/gnome/bin/zapping /opt/gnome/bin/zapzilla

	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}
