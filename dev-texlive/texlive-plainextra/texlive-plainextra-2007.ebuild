# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-plainextra/texlive-plainextra-2007.ebuild,v 1.2 2007/10/25 08:14:25 opfer Exp $

TEXLIVE_MODULES_DEPS="dev-texlive/texlive-basic
"
TEXLIVE_MODULE_CONTENTS="cellular colortab fixpdfmag fontch hyplain jsmisc newsletr pdcmac plgraph treetex typespec vertex collection-plainextra
"
inherit texlive-module
DESCRIPTION="TeXLive Plain TeX supplementary packages"

LICENSE="GPL-2 LPPL-1.3c"
SLOT="0"
KEYWORDS="~x86"
