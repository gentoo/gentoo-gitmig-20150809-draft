# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/koffice-meta/koffice-meta-1.6.3_p20090204.ebuild,v 1.3 2009/07/01 12:55:41 fauli Exp $

MAXKOFFICEVER=${PV}
inherit kde-functions

DESCRIPTION="KOffice - merge this to pull in all KOffice-derived packages."
HOMEPAGE="http://www.koffice.org/"
LICENSE="GPL-2"

SLOT="3.5"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="~app-office/karbon-1.6.3_p20090204
	~app-office/kchart-1.6.3_p20090204
	~app-office/kexi-1.6.3_p20090204
	~app-office/kformula-1.6.3_p20090204
	~app-office/kivio-1.6.3_p20090204
	~app-office/koffice-data-1.6.3_p20090204
	~app-office/koffice-libs-1.6.3_p20090204
	~app-office/koshell-1.6.3_p20090204
	~app-office/kplato-1.6.3_p20090204
	~app-office/kpresenter-1.6.3_p20090204
	~app-office/krita-1.6.3_p20090204
	~app-office/kspread-1.6.3_p20090204
	~app-office/kugar-1.6.3_p20090204
	~app-office/kword-1.6.3_p20090204"
