# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/firestarter/firestarter-0.9.1.ebuild,v 1.8 2003/09/07 00:10:32 msterret Exp $

inherit gnome2 eutils

IUSE="nls"

S=${WORKDIR}/${P}
DESCRIPTION="Gui for iptables firewall setup and monitor."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://firestarter.sf.net"
LICENSE="GPL-2"

RDEPEND=">=x11-libs/gtk+-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libgnome-2
	net-firewall/iptables"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	dev-util/pkgconfig
	>=dev-util/intltool-0.21"

SLOT="0"
KEYWORDS="x86 ~ppc ~sparc alpha"

src_unpack() {
	unpack ${A}

	cd ${S}/src ; epatch ${FILESDIR}/${P}-gcc2_fixes.patch
}

src_compile() {
	local myconf
	use nls \
		&& myconf="${myconf} --enable-nls" \
		|| myconf="${myconf} --disable-nls"
	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall destdir=${D} graphicsdir=${D}/usr/share/pixmaps || die "einstall failed"
	dodoc AUTHORS Changelog COPYING CREDITS INSTALL README TODO
}

pkg_postinstall() {
	./postinstall
}
