# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-documentation-russian/texlive-documentation-russian-2008.ebuild,v 1.8 2009/03/13 20:14:31 ranger Exp $

TEXLIVE_MODULE_CONTENTS="lshort-russian mpman-ru texlive-ru collection-documentation-russian
"
TEXLIVE_MODULE_DOC_CONTENTS="lshort-russian.doc mpman-ru.doc texlive-ru.doc "
TEXLIVE_MODULE_SRC_CONTENTS="texlive-ru.source "
inherit texlive-module
DESCRIPTION="TeXLive Russian documentation"

LICENSE="GPL-2 as-is GPL-1 "
SLOT="0"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~ppc ppc64 ~s390 ~sh sparc x86 ~x86-fbsd"
IUSE=""
DEPEND=">=dev-texlive/texlive-documentation-base-2008
"
RDEPEND="${DEPEND}"
