# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-mixer/xfce4-mixer-3.99.2.ebuild,v 1.3 2003/09/04 07:18:11 msterret Exp $

IUSE="alsa"
S=${WORKDIR}/${P}

DESCRIPTION="Xfce4 Mixer"
HOMEPAGE="http://www.xfce.org/"
SRC_URI="http://www.xfce.org/archive/xfce4-rc2/src/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~alpha ~sparc"

DEPEND=">=x11-libs/gtk+-2.0.6
	dev-util/pkgconfig
	dev-libs/libxml2
	=xfce-base/xfce4-${PV}"

src_compile() {
	local myconf
	myconf=""

	use alsa \
		&& myconf="${myconf} --with-sound=alsa" \
		|| myconf="${myconf} --with-sound=oss"

	econf ${myconf} || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS INSTALL COPYING README TODO
}
