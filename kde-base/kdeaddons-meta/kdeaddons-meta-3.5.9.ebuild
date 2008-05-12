# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeaddons-meta/kdeaddons-meta-3.5.9.ebuild,v 1.4 2008/05/12 20:02:45 ranger Exp $

EAPI="1"
inherit kde-functions
DESCRIPTION="kdeaddons - merge this to pull in all kdeaddons-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="3.5"
KEYWORDS="alpha ~amd64 ~hppa ia64 ppc ~ppc64 sparc ~x86 ~x86-fbsd"
IUSE="arts"

RDEPEND="
>=kde-base/atlantikdesigner-${PV}:${SLOT}
>=kde-base/knewsticker-scripts-${PV}:${SLOT}
>=kde-base/ksig-${PV}:${SLOT}
>=kde-base/kaddressbook-plugins-${PV}:${SLOT}
>=kde-base/kate-plugins-${PV}:${SLOT}
>=kde-base/kicker-applets-${PV}:${SLOT}
>=kde-base/kdeaddons-kfile-plugins-${PV}:${SLOT}
>=kde-base/konq-plugins-${PV}:${SLOT}
>=kde-base/konqueror-akregator-${PV}:${SLOT}
>=kde-base/kdeaddons-docs-konq-plugins-${PV}:${SLOT}
>=kde-base/renamedlg-audio-${PV}:${SLOT}
>=kde-base/renamedlg-images-${PV}:${SLOT}
arts? ( >=kde-base/noatun-plugins-${PV}:${SLOT} )"
