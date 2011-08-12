# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-langarmenian/texlive-langarmenian-2010.ebuild,v 1.4 2011/08/12 15:58:33 xarthisius Exp $

EAPI="3"

TEXLIVE_MODULE_CONTENTS="armenian collection-langarmenian
"
TEXLIVE_MODULE_DOC_CONTENTS="armenian.doc "
TEXLIVE_MODULE_SRC_CONTENTS=""
inherit texlive-module
DESCRIPTION="TeXLive Armenian"

LICENSE="GPL-2 as-is "
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ppc ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd"
IUSE=""
DEPEND=">=dev-texlive/texlive-basic-2010
"
RDEPEND="${DEPEND} "
