# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-langother/texlive-langother-2010.ebuild,v 1.1 2010/10/24 18:11:53 aballier Exp $

EAPI="3"

TEXLIVE_MODULE_CONTENTS="hyphen-afrikaans hyphen-coptic hyphen-esperanto hyphen-estonian hyphen-icelandic hyphen-indonesian hyphen-interlingua hyphen-irish hyphen-kurmanji hyphen-romanian hyphen-serbian hyphen-slovenian hyphen-turkish hyphen-uppersorbian hyphen-welsh hyphen-lao hyphen-armenian collection-langother
"
TEXLIVE_MODULE_DOC_CONTENTS=""
TEXLIVE_MODULE_SRC_CONTENTS=""
inherit texlive-module
DESCRIPTION="TeXLive Other hyphenation files"

LICENSE="GPL-2 as-is GPL-1 LPPL-1.3 "
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""
DEPEND=">=dev-texlive/texlive-basic-2010
!<dev-texlive/texlive-basic-2009
"
RDEPEND="${DEPEND} "
