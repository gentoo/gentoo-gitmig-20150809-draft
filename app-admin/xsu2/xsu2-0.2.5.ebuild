# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/xsu2/xsu2-0.2.5.ebuild,v 1.12 2004/10/05 02:58:11 pvdabeel Exp $

DESCRIPTION="Interface for 'su - username -c command' in GNOME2."
HOMEPAGE="http://xsu.freax.eu.org/"
SRC_URI="http://xsu.freax.eu.org/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc amd64"
IUSE=""

RDEPEND="=gnome-base/libgnome-2*
	=x11-libs/gtk+-2*
	=dev-libs/glib-2*
	=x11-libs/libzvt-2*
	=gnome-base/libgnomeui-2*"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	econf \
		--prefix=/usr || die
	emake || die
}

src_install() {
	dobin src/xsu || die
	doman doc/xsu.8
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
	dohtml -r doc/xsu_*
}
