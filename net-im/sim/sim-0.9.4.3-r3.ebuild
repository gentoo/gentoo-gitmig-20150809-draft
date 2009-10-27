# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/sim/sim-0.9.4.3-r3.ebuild,v 1.8 2009/10/27 14:40:30 pva Exp $

EAPI=1

inherit eutils flag-o-matic qt3

DESCRIPTION="Simple Instant Messenger (with KDE support). ICQ/AIM/Jabber/MSN/Yahoo."
HOMEPAGE="http://sim-im.org/"
SRC_URI="mirror://berlios/sim-im/${P}.tar.bz2
	http://dev.gentoo.org/~pva/${P}-r1919_1924.patch.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="debug spell ssl"

RESTRICT="fetch"

RDEPEND="x11-libs/qt:3
		 spell? ( app-text/aspell )
		 ssl? ( dev-libs/openssl )
		 dev-libs/libxml2
		 dev-libs/libxslt
		 sys-libs/zlib
		 x11-libs/libXScrnSaver"

DEPEND="${RDEPEND}
	sys-devel/flex
	app-arch/zip
	x11-proto/scrnsaverproto"

pkg_nofetch() {
	elog "${CATEGORY}/${P} contains icons and sounds with unclear licensing and thus"
	elog "you have to download it and put into '${DISTDIR}' by yourself."
	elog "Download location:"
	echo
	elog "${SRC_URI}"
	echo
	elog "See http://archives.gentoo.org/gentoo-dev/msg_144003.xml for further"
	elog "information."
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-double-message-fix.patch
	epatch "${FILESDIR}"/${P}-sslv23.patch
	epatch ../${P}-r1919_1924.patch
	epatch "${FILESDIR}"/${P}-old-protocol.patch
}

src_compile() {
	# Workaround for bug #119906
	append-flags -fno-stack-protector

	use spell || export DO_NOT_COMPILE="$DO_NOT_COMPILE plugins/spell"

	econf ${myconf} \
		  $(use_with ssl) \
		  $(use_enable debug) \
		  --without-arts \
		  --disable-kde

	emake -j1 || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed."
	dodoc TODO README AUTHORS.sim jisp-resources.txt ChangeLog
}

pkg_postinst() {
	ewarn "Since kde-3.5 is deprecated sim doesn't have kde support any more (#275316)."
	ewarn "If you have used sim built with kde USE flag enabled to migrate on qt only"
	ewarn "version of sim, please, run the following command:"
	ewarn " $ mv ~/.kde3.5/share/apps/sim ~/.sim"
}
