# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/gift/gift-0.11.7.ebuild,v 1.2 2004/09/08 00:13:46 vapier Exp $

inherit eutils libtool

DESCRIPTION="A OpenFT, Gnutella and FastTrack p2p network daemon"
HOMEPAGE="http://gift.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
IUSE="imagemagick oggvorbis"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc ~alpha ~amd64 ~ia64"

RDEPEND=">=sys-libs/zlib-1.1.4"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	imagemagick? ( >=media-gfx/imagemagick-5.5.7.15 )
	oggvorbis? ( >=media-libs/libvorbis-1 )"

GIFTUSER="p2p"

pkg_preinst() {
	# Add a new user
	enewuser ${GIFTUSER} -1 /bin/bash /home/p2p users
}

src_compile() {
	econf `use_enable imagemagick` \
		`use_enable oggvorbis libvorbis` || die
	emake || die
}

src_install() {
	einstall \
		giftconfdir=${D}/etc/giFT \
		plugindir=${D}/usr/lib/giFT \
		giftdatadir=${D}/usr/share/giFT \
		giftperldir=${D}/usr/bin \
		libgiftincdir=${D}/usr/include/libgift || die "Install failed"

	# init scripts for users who want a central server
	insinto /etc/conf.d; newins ${FILESDIR}/gift.confd gift
	exeinto /etc/init.d; newexe ${FILESDIR}/gift.initd gift

	touch ${D}/usr/share/giFT/giftd.log
	chown ${GIFTUSER}:root ${D}/usr/share/giFT/giftd.log
}

pkg_postinst() {
	einfo "First, you need to run gift-setup with your normal"
	einfo "user account to create the giFT configuration files."
	echo
	einfo "Also, if you will be using the giFT init script, you"
	einfo "will need to create /usr/share/giFT/giftd.conf"
	einfo "This method is only recommended for users with a"
	einfo "central giFT server."
	echo
	einfo "This package no longer contains any protocol plugins,"
	einfo "please try gift-fasttrack, gift-openft, gift-gnutella"
	einfo "for protocol support."
	echo
	einfo "If you encounter issues with this package, please contact"
	einfo "us via bugs.gentoo.org rather than attempting to contact"
	einfo "the upstream developers, as they are hesitant to provide"
	einfo "appropriate and polite support."
}
