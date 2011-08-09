# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-langitalian/texlive-langitalian-2010.ebuild,v 1.2 2011/08/09 21:25:17 hwoarang Exp $

EAPI="3"

TEXLIVE_MODULE_CONTENTS="hyphen-italian frontespizio itnumpar layaureo collection-langitalian
"
TEXLIVE_MODULE_DOC_CONTENTS="frontespizio.doc itnumpar.doc layaureo.doc "
TEXLIVE_MODULE_SRC_CONTENTS="frontespizio.source itnumpar.source layaureo.source "
inherit texlive-module
DESCRIPTION="TeXLive Italian"

LICENSE="GPL-2 LGPL-2 LPPL-1.3 "
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""
DEPEND=">=dev-texlive/texlive-basic-2010
"
RDEPEND="${DEPEND} "
