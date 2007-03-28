# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/sim/sim-0.9.4.3.ebuild,v 1.3 2007/03/28 08:06:13 ticho Exp $

inherit kde-functions eutils flag-o-matic

DESCRIPTION="Simple Instant Messenger (with KDE support). ICQ/AIM/Jabber/MSN/Yahoo."
HOMEPAGE="http://sim-im.org/"
SRC_URI="http://download.berlios.de/sim-im/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="debug kde spell ssl"

RESTRICT="fetch"

# kdebase-data provides the icon "licq.png"
RDEPEND="kde? ( kde-base/kdelibs
				|| ( kde-base/kdebase-data kde-base/kdebase ) )
		 !kde? ( $(qt_min_version 3)
				 spell? ( app-text/aspell ) )
		 ssl? ( dev-libs/openssl )
		 dev-libs/libxml2
		 dev-libs/libxslt
		 sys-libs/zlib
		 || ( x11-libs/libXScrnSaver virtual/x11 )"

DEPEND="${RDEPEND}
	sys-devel/flex
	app-arch/zip
	|| ( x11-proto/scrnsaverproto virtual/x11 )"

pkg_nofetch() {
	einfo "${CATEGORY}/${P} contains icons and sounds with unclear licensing and thus"
	einfo "you have to download and it put into ${DISTDIR} by yourself."
	einfo "Download location:"
	echo
	einfo "${SRC_URI}"
	echo
	einfo "See http://archives.gentoo.org/gentoo-dev/msg_144003.xml for further"
	einfo "information."
}

pkg_setup() {
	if use kde ; then
		if use spell; then
			if ! built_with_use kde-base/kdelibs spell ; then
				ewarn "kde-base/kdelibs were merged without spell in USE."
				ewarn "Thus spelling will not work in sim. Please, either"
				ewarn "reemerge kde-base/kdelibs with spell in USE or emerge"
				ewarn 'sim with USE="-spell" to avoid this message.'
				ebeep
			fi
		else
			if built_with_use kde-base/kdelibs spell ; then
				ewarn 'kde-base/kdelibs were merged with spell in USE.'
				ewarn 'Thus spelling will work in sim. Please, either'
				ewarn 'reemerge kde-base/kdelibs without spell in USE or emerge'
				ewarn 'sim with USE="spell" to avoid this message.'
				ebeep
			fi
		fi
		if ! built_with_use kde-base/kdelibs arts ; then
			myconf="--without-arts"
		fi
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}

	if use kde ; then
	set-kdedir 3
	fi
}

src_compile() {
	filter-flags -fstack-protector -fstack-protector-all

	# Workaround for bug #119906
	append-flags -fno-stack-protector

	use kde || use spell || export DO_NOT_COMPILE="$DO_NOT_COMPILE plugins/spell"

	econf ${myconf} `use_enable kde` \
		  `use_with ssl` \
		  `use_enable debug` || die "econf failed"

	emake -j1 || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed."
	dodoc TODO README AUTHORS.sim jisp-resources.txt ChangeLog
}
