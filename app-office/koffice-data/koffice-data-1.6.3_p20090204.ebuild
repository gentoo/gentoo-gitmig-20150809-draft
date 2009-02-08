# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/koffice-data/koffice-data-1.6.3_p20090204.ebuild,v 1.1 2009/02/08 17:23:49 carlo Exp $

ARTS_REQUIRED="never"

KMNAME=koffice
KMMODULE=
inherit kde-meta eutils

DESCRIPTION="Shared KOffice data files."
HOMEPAGE="http://www.koffice.org/"
LICENSE="GPL-2 LGPL-2"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

KMEXTRA="
	mimetypes/
	servicetypes/
	pics/
	templates/
	autocorrect/"

need-kde 3.5
