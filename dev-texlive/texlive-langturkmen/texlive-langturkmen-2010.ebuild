# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-langturkmen/texlive-langturkmen-2010.ebuild,v 1.1 2010/10/24 18:11:51 aballier Exp $

EAPI="3"

TEXLIVE_MODULE_CONTENTS="turkmen hyphen-turkmen collection-langturkmen
"
TEXLIVE_MODULE_DOC_CONTENTS="turkmen.doc "
TEXLIVE_MODULE_SRC_CONTENTS="turkmen.source "
inherit texlive-module
DESCRIPTION="TeXLive Turkmen"

LICENSE="GPL-2 LPPL-1.3 "
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE=""
DEPEND=">=dev-texlive/texlive-basic-2010
"
RDEPEND="${DEPEND} "
