# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-admin/procman/procman-0.99.0.ebuild,v 1.6 2002/08/16 02:21:27 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Process viewer for GNOME"
SRC_URI="http://www.personal.psu.edu/users/k/f/kfv101/${PN}/source/${P}.tar.gz"
HOMEPAGE="http://www.personal.psu.edu/kfv101/procman"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

DEPEND=">=gnome-extra/gal-0.13-r1
	>=gnome-base/libgtop-1.0.12-r1"

RDEPEND="nls? ( sys-devel/gettext )"

src_compile() {
	local myconf

	use nls || myconf="--disable-nls"

	CFLAGS="$CFLAGS `gdk-pixbuf-config --cflags`"
	econf \
		--disable-more-warnings \
		${myconf} || die

	emake || die
}

src_install () {
	einstall || die

	dodoc AUTHORS COPYING ChangeLog README NEWS TODO
}
