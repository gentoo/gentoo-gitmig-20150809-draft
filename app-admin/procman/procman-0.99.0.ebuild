# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/procman/procman-0.99.0.ebuild,v 1.15 2004/03/12 10:45:39 mr_bones_ Exp $

DESCRIPTION="Process viewer for GNOME"
SRC_URI="http://www.personal.psu.edu/users/k/f/kfv101/procman/source/${P}.tar.gz"
HOMEPAGE="http://www.personal.psu.edu/kfv101/procman"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc"
IUSE="nls"

DEPEND="<gnome-extra/gal-1.99
	=gnome-base/libgtop-1*"
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
