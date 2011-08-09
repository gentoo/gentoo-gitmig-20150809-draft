# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-langfrench/texlive-langfrench-2010.ebuild,v 1.3 2011/08/09 21:23:26 hwoarang Exp $

EAPI="3"

TEXLIVE_MODULE_CONTENTS="aeguill bib-fr frenchle frletter mafr tabvar tdsfrmath variations hyphen-basque hyphen-french collection-langfrench
"
TEXLIVE_MODULE_DOC_CONTENTS="aeguill.doc bib-fr.doc frenchle.doc frletter.doc mafr.doc tabvar.doc tdsfrmath.doc variations.doc "
TEXLIVE_MODULE_SRC_CONTENTS="tabvar.source tdsfrmath.source "
inherit texlive-module
DESCRIPTION="TeXLive French"

LICENSE="GPL-2 as-is GPL-1 LPPL-1.3 public-domain "
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~ppc-macos"
IUSE=""
DEPEND=">=dev-texlive/texlive-basic-2010
"
RDEPEND="${DEPEND} "
