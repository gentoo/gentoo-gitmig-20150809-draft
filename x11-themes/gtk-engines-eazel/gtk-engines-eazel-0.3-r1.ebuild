# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-eazel/gtk-engines-eazel-0.3-r1.ebuild,v 1.4 2004/01/12 21:37:13 gustavoz Exp $

inherit gtk-engines2

MY_PN="eazel-engine"

IUSE=""
DESCRIPTION="GTK+1 Eazel Theme Engine"
SRC_URI="http://ftp.debian.org/debian/pool/main/e/${MY_PN}/${MY_PN}_${PV}.orig.tar.gz"
KEYWORDS="x86 ~ppc sparc ~alpha hppa"
LICENSE="GPL-2"
SLOT="1"

DEPEND="=x11-libs/gtk+-1.2*
	media-libs/gdk-pixbuf
	=gnome-base/control-center-1.4*"

S=${WORKDIR}/${MY_PN}-${PV}
