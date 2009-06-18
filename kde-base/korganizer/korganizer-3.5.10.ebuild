# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/korganizer/korganizer-3.5.10.ebuild,v 1.5 2009/06/18 05:23:53 jer Exp $

KMNAME=kdepim
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="A Personal Organizer for KDE."
KEYWORDS="~alpha amd64 hppa ~ia64 ppc ppc64 ~sparc x86 ~x86-fbsd"
IUSE=""
DEPEND=">=kde-base/libkpimexchange-${PV}:${SLOT}
>=kde-base/libkdepim-${PV}:${SLOT}
>=kde-base/libkcal-${PV}:${SLOT}
>=kde-base/libkpimidentities-${PV}:${SLOT}
>=kde-base/ktnef-${PV}:${SLOT}
>=kde-base/kdepim-kresources-${PV}:${SLOT}
>=kde-base/kontact-${PV}:${SLOT}
>=kde-base/libkholidays-${PV}:${SLOT}
>=kde-base/libkmime-${PV}:${SLOT}"
RDEPEND="${DEPEND}"

KMCOPYLIB="
	libkdepim libkdepim
	libkpimexchange libkpimexchange
	libkcal libkcal
	libkpimidentities libkpimidentities
	libktnef ktnef/lib
	libkcal_resourceremote kresources/remote
	libkpinterfaces kontact/interfaces
	libkholidays libkholidays
	libkmime libkmime"
KMEXTRACTONLY="
	libkpimexchange/
	libkcal/
	libkdepim/
	libkpimidentities/
	libkmime/
	mimelib/
	ktnef/
	certmanager/lib/
	kresources/remote/
	kmail/kmailIface.h
	kontact/interfaces/
	libkholidays"
KMCOMPILEONLY="
	libemailfunctions"

# They seems to be used only by korganizer
KMEXTRA="
	kgantt
	kdgantt
	kontact/plugins/korganizer/" # We add here the kontact's plugin instead of compiling it with kontact because it needs a lot of korganizer deps.

src_unpack() {
	kde-meta_src_unpack

	# Broken test
	sed -e "s:check_PROGRAMS = testalarmdlg:check_PROGRAMS =:" -i korganizer/korgac/Makefile.am || die "sed failed"
}

src_compile() {
	filter-flags -fvisibility-inlines-hidden
	kde_src_compile
}
