# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-misc/firestarter/firestarter-0.9.0.ebuild,v 1.4 2002/08/30 03:36:55 gerk Exp $

#MY_P=firestarter-${PV}
S=${WORKDIR}/${P}
DESCRIPTION="Gui for firewalls (iptables & ipchains), and a firewall monitor."
SRC_URI="mirror://sourceforge/firestarter/${P}.tar.gz"
HOMEPAGE="http://firestarter.sf.net"
LICENSE="GPL-2"

DEPEND="x11-libs/gtk+
	gnome-base/libgnome	
	sys-apps/iptables
	nls? ( sys-devel/gettext )"
RDEPEND="${DEPEND}"
SLOT="0"
KEYWORDS="x86 ppc sparc sparc64"

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
	dodoc AUTHORS Changelog README TODO

}

pkg_postinstall() {
	./postinstall
}
