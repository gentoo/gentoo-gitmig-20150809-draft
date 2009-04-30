# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim-kresources/kdepim-kresources-3.5.10.ebuild,v 1.2 2009/04/30 17:18:16 tampakrap Exp $

KMNAME=kdepim
KMMODULE=kresources
EAPI="1"
inherit kde-meta eutils

SRC_URI="${SRC_URI}
	mirror://gentoo/kdepim-3.5-patchset-06.tar.bz2"

DESCRIPTION="KDE PIM groupware plugin collection"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""
DEPEND=">=kde-base/libkmime-${PV}:${SLOT}
	>=kde-base/libkcal-${PV}:${SLOT}
	>=kde-base/libkpimexchange-${PV}:${SLOT}
	>=kde-base/libkdepim-${PV}:${SLOT}
	>=kde-base/kaddressbook-${PV}:${SLOT}
	>=kde-base/kode-${PV}:${SLOT}
	dev-libs/libical
	>=app-crypt/gpgme-1.0.2"
RDEPEND="${DEPEND}"

# Tests fail due to a missing file (kde-features_parser.custom.h) which
# is not in the kdepim tarball.
RESTRICT="test"

KMCOPYLIB="
	libkmime libkmime
	libkcal libkcal
	libkpimexchange libkpimexchange
	libkdepim libkdepim
	libkabinterfaces kaddressbook/interfaces/"

KMEXTRACTONLY="
	korganizer/
	libkpimexchange/configure.in.in
	libkdepim/
	kmail/kmailicalIface.h
	libkpimexchange/
	libemailfunctions/
	libkmime/kmime_util.h"

KMCOMPILEONLY="
	knotes/
	libkcal/
	kaddressbook/common/"

PATCHES="${WORKDIR}/patches/kdepim-kresources-3.5_use-installed-kode.diff"

src_compile() {
	export DO_NOT_COMPILE="knotes libkcal"

	kde-meta_src_compile myconf configure

	cd knotes/; make libknotesresources.la
	cd "${S}"/libkcal/libical/src/libical ; emake ical.h

	kde-meta_src_compile make
}
