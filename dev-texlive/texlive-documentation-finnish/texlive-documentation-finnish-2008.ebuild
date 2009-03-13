# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-documentation-finnish/texlive-documentation-finnish-2008.ebuild,v 1.8 2009/03/13 20:12:36 ranger Exp $

TEXLIVE_MODULE_CONTENTS="lshort-finnish collection-documentation-finnish
"
TEXLIVE_MODULE_DOC_CONTENTS="lshort-finnish.doc "
TEXLIVE_MODULE_SRC_CONTENTS=""
inherit texlive-module
DESCRIPTION="TeXLive Finnish documentation"

LICENSE="GPL-2 freedist "
SLOT="0"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~ppc ppc64 ~s390 ~sh sparc x86 ~x86-fbsd"
IUSE=""
DEPEND=">=dev-texlive/texlive-documentation-base-2008
"
RDEPEND="${DEPEND}"
