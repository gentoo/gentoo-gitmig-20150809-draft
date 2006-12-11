# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim-kresources/kdepim-kresources-3.5.5.ebuild,v 1.9 2006/12/11 13:22:52 kloeri Exp $

KMNAME=kdepim
KMMODULE=kresources
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE PIM groupware plugin collection"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""
DEPEND="$(deprange $PV $MAXKDEVER kde-base/libkcal)
$(deprange $PV $MAXKDEVER kde-base/libkpimexchange)
$(deprange $PV $MAXKDEVER kde-base/libkdepim)
$(deprange $PV $MAXKDEVER kde-base/kaddressbook)
$(deprange 3.5.2 $MAXKDEVER kde-base/kode)
	dev-libs/libical
	>=app-crypt/gpgme-1.0.2"
RDEPEND="${DEPEND}"

KMCOPYLIB="
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
	libemailfunctions/"

KMCOMPILEONLY="
	knotes/
	libkcal/
	kaddressbook/common/
	"
PATCHES="$FILESDIR/use-installed-kode.diff"

src_compile() {
	export DO_NOT_COMPILE="knotes libkcal"

	kde-meta_src_compile myconf configure

	cd knotes/; make libknotesresources.la
	cd $S/libkcal/libical/src/libical; make ical.h

	kde-meta_src_compile make
}
