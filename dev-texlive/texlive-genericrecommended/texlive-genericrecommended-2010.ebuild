# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-genericrecommended/texlive-genericrecommended-2010.ebuild,v 1.2 2010/12/17 20:55:00 grobian Exp $

EAPI="3"

TEXLIVE_MODULE_CONTENTS="epsf fontname genmisc kastrup multido path tex-ps ulem collection-genericrecommended
"
TEXLIVE_MODULE_DOC_CONTENTS="epsf.doc fontname.doc kastrup.doc multido.doc path.doc tex-ps.doc ulem.doc "
TEXLIVE_MODULE_SRC_CONTENTS="kastrup.source multido.source "
inherit texlive-module
DESCRIPTION="TeXLive Recommended generic packages"

LICENSE="GPL-2 as-is GPL-1 LPPL-1.3 public-domain "
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~ppc-macos"
IUSE=""
DEPEND=">=dev-texlive/texlive-basic-2010
!=dev-texlive/texlive-basic-2007*
!<dev-texlive/texlive-texinfo-2009
!<dev-texlive/texlive-latexextra-2010
"
RDEPEND="${DEPEND} "
