# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-genericrecommended/texlive-genericrecommended-2007.ebuild,v 1.16 2008/09/09 18:15:08 aballier Exp $

TEXLIVE_MODULES_DEPS="dev-texlive/texlive-basic
"
TEXLIVE_MODULE_CONTENTS="epsf genmisc multido tex-ps collection-genericrecommended
"
inherit texlive-module
DESCRIPTION="TeXLive Miscellaneous generic macros"

LICENSE="GPL-2 LPPL-1.3c"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""
