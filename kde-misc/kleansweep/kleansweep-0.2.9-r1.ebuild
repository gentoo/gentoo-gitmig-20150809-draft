# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kleansweep/kleansweep-0.2.9-r1.ebuild,v 1.1 2008/09/15 00:03:32 carlo Exp $

ARTS_REQUIRED="never"

inherit kde

DESCRIPTION=" KleanSweep allows you to reclaim disk space by finding unneeded files."
HOMEPAGE="http://linux.bydg.org/~yogin/"
SRC_URI="http://linux.bydg.org/~yogin/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

DEPEND="=dev-util/scons-0.97*
	>=dev-lang/python-2.3"
need-kde 3.5

PATCHES=( "${FILESDIR}/kleansweep-0.2.9-desktop-entry-fix.diff" )

src_compile() {
	[ -d "$QTDIR/etc/settings" ] && addwrite "$QTDIR/etc/settings"
	addpredict "$QTDIR/etc/settings"

	local myconf="kdeincludes=$(kde-config --prefix)/include prefix=/usr "
	use amd64 && myconf="${myconf} libsuffix=64"

	scons configure ${myconf} || die "configure failed"
	scons ${MAKEOPTS} || die "scons failed"
}

src_install() {
	DESTDIR="${D}" scons install || die "install failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
}
