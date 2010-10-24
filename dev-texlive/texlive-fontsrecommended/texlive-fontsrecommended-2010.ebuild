# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-fontsrecommended/texlive-fontsrecommended-2010.ebuild,v 1.1 2010/10/24 18:11:54 aballier Exp $

EAPI="3"

TEXLIVE_MODULE_CONTENTS="avantgar bookman charter cm-super cmextra courier euro euro-ce eurofont eurosans eurosym fpl helvetic lm marvosym mathpazo ncntrsbk palatino pxfonts rsfs symbol tex-gyre times tipa txfonts utopia wasy wasysym zapfchan zapfding collection-fontsrecommended
"
TEXLIVE_MODULE_DOC_CONTENTS="charter.doc cm-super.doc euro.doc euro-ce.doc eurofont.doc eurosans.doc eurosym.doc fpl.doc lm.doc marvosym.doc mathpazo.doc pxfonts.doc rsfs.doc tex-gyre.doc tipa.doc txfonts.doc utopia.doc wasy.doc wasysym.doc "
TEXLIVE_MODULE_SRC_CONTENTS="euro.source eurofont.source fpl.source lm.source mathpazo.source wasysym.source "
inherit texlive-module
DESCRIPTION="TeXLive Recommended fonts"

LICENSE="GPL-2 as-is GPL-1 LPPL-1.3 public-domain "
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""
DEPEND=">=dev-texlive/texlive-basic-2010
!=dev-texlive/texlive-basic-2007*
!<dev-texlive/texlive-fontsextra-2010
"
RDEPEND="${DEPEND} "
