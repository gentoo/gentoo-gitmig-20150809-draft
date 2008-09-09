# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-langfrench/texlive-langfrench-2008.ebuild,v 1.1 2008/09/09 16:36:11 aballier Exp $

TEXLIVE_MODULES_DEPS="dev-texlive/texlive-basic
"
TEXLIVE_MODULE_CONTENTS="aeguill frenchle frletter mafr tabvar tdsfrmath variations hyphen-basque hyphen-french collection-langfrench
"
TEXLIVE_MODULE_DOC_CONTENTS="aeguill.doc frenchle.doc frletter.doc mafr.doc tabvar.doc tdsfrmath.doc variations.doc "
TEXLIVE_MODULE_SRC_CONTENTS="tabvar.source tdsfrmath.source "
inherit texlive-module
DESCRIPTION="TeXLive French"

LICENSE="GPL-2 GPL-1 LPPL-1.3 public-domain "
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""
