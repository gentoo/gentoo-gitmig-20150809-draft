# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/ee/ee-0.3.12-r2.ebuild,v 1.11 2003/12/16 00:46:53 avenj Exp $

inherit gnuconfig

IUSE="nls"

S=${WORKDIR}/${P}
DESCRIPTION="ee"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnome.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc amd64"

DEPEND="=sys-libs/db-1*
	>=gnome-base/gnome-libs-1.4.1.2-r1"
RDEPEND="nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/${PN}-mo.diff
}

src_compile() {
	gnuconfig_update

	local myconf
	use nls && myconf="--enable-nls" || myconf="--disable-nls"

	econf ${myconf} || die "configure failure"
	emake || die "make failure"
}

src_install() {
	make DESTDIR=${D} \
	     prefix=/usr \
	     install || die "make install failure"
	dodoc AUTHORS COPYING ChangeLog NEWS README
}
