# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/procman/procman-1.0.ebuild,v 1.20 2004/05/31 19:21:33 vapier Exp $

DESCRIPTION="Process viewer for GNOME"
HOMEPAGE="http://www.personal.psu.edu/kfv101/procman"
SRC_URI="mirror://gnome/sources/procman/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc"
IUSE="nls"

DEPEND="<gnome-extra/gal-1.99
	=gnome-base/libgtop-1.0*"
RDEPEND="nls? ( sys-devel/gettext )"

src_compile() {
	local myconf
	use nls || myconf="--disable-nls"

	CFLAGS="$CFLAGS `gdk-pixbuf-config --cflags`"
	econf --disable-more-warnings ${myconf} || die "econf failed"

	emake || die
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog README NEWS TODO
}
