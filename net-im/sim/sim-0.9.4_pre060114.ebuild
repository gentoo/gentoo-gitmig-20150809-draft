# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/sim/sim-0.9.4_pre060114.ebuild,v 1.2 2006/01/16 09:58:18 pva Exp $

inherit kde-functions eutils debug

myver=${PV##*_pre}

DESCRIPTION="Simple Instant Messenger (with KDE support). ICQ/AIM/Jabber/MSN/Yahoo."
HOMEPAGE="http://developer.berlios.de/projects/sim-im/"
#SRC_URI="http://developer.berlios.de/projects/sim-im/${P}.tar.bz2"
SRC_URI="mirror://gentoo/${PN}-${myver}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="kde spell ssl"

# kdebase-data provides the icon "licq.png"
RDEPEND="kde? ( kde-base/kdelibs
			    || ( kde-base/kdebase-data kde-base/kdebase ) )
		 !kde? ( $(qt_min_version 3)
		         spell? ( app-text/aspell ) )
		 ssl? ( dev-libs/openssl )
		 dev-libs/libxml2
		 dev-libs/libxslt"

DEPEND="${RDEPEND}
	sys-devel/flex
	app-arch/zip"

S=${WORKDIR}/${PN}-${myver}

pkg_setup() {
	if [ -z ${myver} ] ; then
		ewarn "Building svn version exported on ${myver}."
	fi
	if use kde ; then
		if has_version net-im/sim ; then
			if ! built_with_use net-im/sim kde ; then
				ewarn 'Your system already has sim emerged with USE="-kde".'
				ewarn 'Now you are trying to emerge it with kde support.'
				ewarn 'Sim has problem that leads to compilation failure in such case.'
				ewarn 'To emerge sim with kde support, first clean out previous'
				ewarn 'installation with `emerge -C sim` and then try again.'
				die "Previous installation found. Unmerge it first."
			fi
		fi
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
	else
		if has_version net-im/sim ; then
			if built_with_use net-im/sim kde ; then
				ewarn 'Your system already has sim emerged with USE="kde".'
				ewarn 'Now you are trying to emerge it without kde support.'
				ewarn 'Sim has problem that leads to compilation failure in such case.'
				ewarn 'To emerge sim without kde support, first clean out previous'
				ewarn 'installation with `emerge -C sim` and then try again.'
				die "Previous installation found. Unmerge it first."
			fi
		fi
	fi
}

src_compile() {
	need-autoconf 2.5
	need-automake 1.7

	if use kde ; then
		set-kdedir 3
	fi

	make -f admin/Makefile.common || die "Failed to create Makefiles..."

	if ! use kde ; then
		use spell || export DO_NOT_COMPILE="$DO_NOT_COMPILE plugins/spell"
	fi

	econf ${myconf} `use_enable kde` \
		  `use_with ssl` \
		  `use_enable debug` || die "econf failed"

	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed."
	dodoc TODO README AUTHORS.sim ChangeLog AUTHORS
}
