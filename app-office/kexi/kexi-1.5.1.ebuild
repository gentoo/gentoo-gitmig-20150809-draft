# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/kexi/kexi-1.5.1.ebuild,v 1.4 2006/08/16 12:53:40 corsair Exp $

MAXKOFFICEVER=${PV}
KMNAME=koffice
inherit kde-meta eutils

DESCRIPTION="KOffice integrated environment for database management."
HOMEPAGE="http://www.koffice.org/"
LICENSE="GPL-2 LGPL-2"

SLOT="0"
KEYWORDS="~alpha ~amd64 ppc ppc64 ~sparc ~x86"
IUSE="mysql postgres"

RDEPEND="$(deprange $PV $MAXKOFFICEVER app-office/koffice-libs)
	sys-libs/readline
	mysql? ( dev-db/mysql )
	postgres? ( dev-libs/libpqxx )
	dev-lang/python"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

KMCOPYLIB="
	libkformula lib/kformula
	libkofficecore lib/kofficecore
	libkofficeui lib/kofficeui
	libkopainter lib/kopainter
	libkoproperty lib/koproperty
	libkotext lib/kotext
	libkwmf lib/kwmf
	libkowmf lib/kwmf
	libkstore lib/store
	libkrossmain lib/kross/main/
	libkrossapi lib/kross/api/"

KMEXTRACTONLY="lib/"

need-kde 3.4

PATCHES="${FILESDIR}/kexi-1.5.1-form_plugins.patch
	${FILESDIR}/kexi-1.5.1-kexi_checkbox_data_saving.patch"

src_compile() {
	local myconf="$(use_enable mysql) $(use_enable postgres pgsql) --enable-kexi-reports"

	kde-meta_src_compile
}
