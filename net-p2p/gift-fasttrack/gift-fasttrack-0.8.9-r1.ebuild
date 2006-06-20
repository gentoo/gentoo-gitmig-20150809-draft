# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/gift-fasttrack/gift-fasttrack-0.8.9-r1.ebuild,v 1.1 2006/06/20 18:34:23 squinky86 Exp $

inherit multilib

IUSE=""

MY_P=${P/gift-fasttrack/giFT-FastTrack}

DESCRIPTION="FastTrack Plugin for giFT"
HOMEPAGE="https://developer.berlios.de/projects/gift-fasttrack/"
SRC_URI="http://download.berlios.de/${PN}/${MY_P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"

DEPEND="virtual/libc
	dev-util/pkgconfig"

RDEPEND=">=net-p2p/gift-0.11.1
	>=sys-libs/zlib-1.1.4"

S=${WORKDIR}/${MY_P}

src_compile() {
#	cp /usr/share/libtool/ltmain.sh .
#	./autogen.sh --prefix=/usr --host=${CHOST} || die "FastTrack configure failed"
	econf || die "FastTrack plugin failed to configure"
	emake || die "FastTrack plugin failed to build"
}

src_install() {
	make DESTDIR=${D} \
		giftconfdir=/etc/giFT \
		plugindir=/usr/$(get_libdir)/giFT \
		libgiftincdir=/usr/include/libgift \
		install || die "Install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
}

pkg_postinst() {
	einfo "It is recommended that you re-run gift-setup as"
	einfo "the user you will run the giFT daemon as:"
	einfo "\tgift-setup"
	echo
	einfo "Alternatively you can add the following line to"
	einfo "your ~/.giFT/giftd.conf configuration file:"
	einfo "plugins = OpenFT:FastTrack"
}
