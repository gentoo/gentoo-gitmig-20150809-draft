# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/gift/gift-0.11.1.ebuild,v 1.4 2003/09/10 05:32:54 vapier Exp $

inherit debug flag-o-matic
strip-flags

DESCRIPTION="A OpenFT, Gnutella and FastTrack p2p network client"
HOMEPAGE="http://gift.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P/ft/FT}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc ~alpha"

DEPEND="virtual/glibc
	!net-p2p/gift
	>=sys-apps/sed-4
	>=sys-libs/zlib-1.1.4"

S=${WORKDIR}/${P/ft/FT}

src_compile() {
	econf --enable-gnutella || die "Configure"
#	./autogen.sh --prefix=/usr --enable-gnutella --host=${CHOST} || die "Bootstrap configure failed"
	emake CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" || die "Make failed"
}

src_install() {
	einstall \
		giftconfdir=${D}/etc/giFT \
		plugindir=${D}/usr/lib/giFT \
		giftdatadir=${D}/usr/share/giFT \
		giftperldir=${D}/usr/bin \
		libgiftincdir=${D}/usr/include/libgift || die "Install failed"

	# Fix the giFT-setup executable.
	cd ${D}/usr/bin
	sed -i -e 's:$prefix/etc/giFT/:/etc/giFT/:' giFT-setup
}

pkg_postinst() {
	einfo "First of all you need to run giFT-setup with your normal"
	einfo "user account to create the giFT configuration files."
	echo
	einfo "If you encounter issues with this package, please contact"
	einfo "us via bugs.gentoo.org rather than attempting to contact"
	einfo "the upstream developers, as they are hesitant to provide"
	einfo "appropriate and polite support"
}
