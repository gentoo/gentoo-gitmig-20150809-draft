# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/koffice-data/koffice-data-1.3.5.ebuild,v 1.6 2005/07/12 17:14:38 josejx Exp $

MAXKOFFICEVER=1.3.5
KMNAME=koffice
KMMODULE=
inherit kde-meta eutils

DESCRIPTION="shared koffice data files"
HOMEPAGE="http://www.koffice.org/"
SRC_URI="$SRC_URI mirror://kde/stable/${KMNAME}/src/${KMNAME}-${PV}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
KEYWORDS="~amd64 ppc ~ppc64 x86"

IUSE=""
SLOT="0"

DEPEND="dev-util/pkgconfig"

KMEXTRA="
	mimetypes/
	servicetypes/
	pics/
	templates/
	autocorrect/"

need-kde 3.1