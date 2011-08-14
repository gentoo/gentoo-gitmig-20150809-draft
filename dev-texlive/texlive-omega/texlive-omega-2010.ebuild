# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-omega/texlive-omega-2010.ebuild,v 1.5 2011/08/14 18:17:06 maekke Exp $

EAPI="3"

TEXLIVE_MODULE_CONTENTS="antomega lambda mxd mxedruli omega aleph omegaware collection-omega
"
TEXLIVE_MODULE_DOC_CONTENTS="antomega.doc mxd.doc mxedruli.doc omega.doc aleph.doc omegaware.doc "
TEXLIVE_MODULE_SRC_CONTENTS="antomega.source "
inherit texlive-module
DESCRIPTION="TeXLive Omega"

LICENSE="GPL-2 as-is GPL-1 LPPL-1.3 "
SLOT="0"
KEYWORDS="~alpha amd64 arm ~hppa ~ia64 ~mips ppc ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd"
IUSE=""
DEPEND=">=dev-texlive/texlive-basic-2010
>=dev-texlive/texlive-latex-2010
>=dev-texlive/texlive-latex-2008
!<dev-texlive/texlive-fontsextra-2009
"
RDEPEND="${DEPEND} "
