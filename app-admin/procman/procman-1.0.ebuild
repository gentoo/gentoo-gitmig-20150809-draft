# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/procman/procman-1.0.ebuild,v 1.14 2003/03/28 10:00:45 pvdabeel Exp $

DESCRIPTION="Process viewer for GNOME"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/procman/${P}.tar.gz"
HOMEPAGE="http://www.personal.psu.edu/kfv101/procman"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc ~ppc"
IUSE="nls"

DEPEND=">=gnome-extra/gal-0.13-r1
	=gnome-base/libgtop-1.0*"
RDEPEND="nls? ( sys-devel/gettext )"

src_compile() {
	local myconf
	use nls || myconf="--disable-nls"

	CFLAGS="$CFLAGS `gdk-pixbuf-config --cflags`"
	econf --disable-more-warnings ${myconf}

	emake || die
}

src_install() {
	einstall

	dodoc AUTHORS COPYING ChangeLog README NEWS TODO
}
