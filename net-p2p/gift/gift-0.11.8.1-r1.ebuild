# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/gift/gift-0.11.8.1-r1.ebuild,v 1.1 2007/04/20 14:20:04 armin76 Exp $

inherit eutils libtool

DESCRIPTION="A OpenFT, Gnutella and FastTrack p2p network daemon"
HOMEPAGE="http://gift.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
IUSE="ares fasttrack gnutella imagemagick openft vorbis"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ia64 x86 ~x86-fbsd"

DEPEND=">=sys-libs/zlib-1.1.4
	sys-apps/file
	imagemagick? ( >=media-gfx/imagemagick-5.5.7.15 )
	vorbis? ( >=media-libs/libvorbis-1 )"
PDEPEND="ares? ( net-p2p/gift-ares )
	fasttrack? ( net-p2p/gift-fasttrack )
	gnutella? ( net-p2p/gift-gnutella )
	openft? ( net-p2p/gift-openft )"

GIFTUSER="p2p"

pkg_preinst() {
	# Add a new user
	enewuser ${GIFTUSER} -1 /bin/bash /home/p2p users
}

src_compile() {
	econf --enable-libmagic \
		`use_enable imagemagick` \
		`use_enable vorbis libvorbis` || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die "Install failed"

	# init scripts for users who want a central server
	insinto /etc/conf.d; newins ${FILESDIR}/gift.confd gift
	exeinto /etc/init.d; newexe ${FILESDIR}/gift.initd gift

	touch ${D}/usr/share/giFT/giftd.log
	chown ${GIFTUSER}:root ${D}/usr/share/giFT/giftd.log
}

pkg_postinst() {
	einfo "Configure gift in /usr/share/giFT/ or run gift-setup"
	einfo "as normal user and make:"
	einfo 'cp -R $HOME/.giFT/* /usr/share/giFT/'
	einfo "chown -R p2p:root /usr/share/giFT/*"
	einfo "(be carefull while specyfing directories in gift-setup;"
	einfo "keep in mind that giFT will run as process of user "
	einfo 'specified in /etc/conf.d/gift with his $HOME directory)'
	echo
	einfo "Also, if you will be using the giFT init script, you"
	einfo "will need to create /usr/share/giFT/giftd.conf"
	einfo "This method is only recommended for users with a"
	einfo "central giFT server."
	echo
	einfo "This package no longer contains any protocol plugins,"
	einfo "please try gift-fasttrack, gift-openft, gift-gnutella"
	einfo "for protocol support."
}
