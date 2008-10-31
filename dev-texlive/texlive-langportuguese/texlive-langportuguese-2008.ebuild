# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-langportuguese/texlive-langportuguese-2008.ebuild,v 1.2 2008/10/31 14:38:35 aballier Exp $

TEXLIVE_MODULE_CONTENTS="ordinalpt hyphen-portuguese collection-langportuguese
"
TEXLIVE_MODULE_DOC_CONTENTS="ordinalpt.doc "
TEXLIVE_MODULE_SRC_CONTENTS="ordinalpt.source "
inherit texlive-module
DESCRIPTION="TeXLive Portuguese"

LICENSE="GPL-2 LPPL-1.3 "
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""
DEPEND=">=dev-texlive/texlive-basic-2008
"
RDEPEND="${DEPEND}"
