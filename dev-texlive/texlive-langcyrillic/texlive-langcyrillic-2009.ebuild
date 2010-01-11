# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-langcyrillic/texlive-langcyrillic-2009.ebuild,v 1.1 2010/01/11 03:20:42 aballier Exp $

TEXLIVE_MODULE_CONTENTS="cmcyr cmcyralt cyrillic cyrillic-bin cyrplain disser eskd eskdx gost lcyw lh lhcyr ruhyphen t2 timescyr ukrhyph hyphen-bulgarian hyphen-russian hyphen-ukrainian collection-langcyrillic
"
TEXLIVE_MODULE_DOC_CONTENTS="cmcyr.doc cmcyralt.doc cyrillic.doc cyrillic-bin.doc disser.doc eskd.doc eskdx.doc gost.doc lcyw.doc lh.doc t2.doc ukrhyph.doc "
TEXLIVE_MODULE_SRC_CONTENTS="cmcyralt.source cyrillic.source disser.source eskd.source gost.source lcyw.source lh.source lhcyr.source ruhyphen.source "
inherit texlive-module
DESCRIPTION="TeXLive Cyrillic"

LICENSE="GPL-2 as-is freedist LPPL-1.3 public-domain "
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""
DEPEND=">=dev-texlive/texlive-basic-2009
>=dev-texlive/texlive-latex-2009
"
RDEPEND="${DEPEND} "
