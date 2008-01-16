# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-formatsextra/texlive-formatsextra-2007.ebuild,v 1.8 2008/01/16 23:00:47 aballier Exp $

TEXLIVE_MODULES_DEPS="dev-texlive/texlive-basic
dev-texlive/texlive-latex
"
TEXLIVE_MODULE_CONTENTS="alatex bin-eplain bin-mltex bin-physe bin-phyzzx bin-texsis edmac eplain mltex physe phyzzx psizzl startex texsis ytex collection-formatsextra
"
inherit texlive-module
DESCRIPTION="TeXLive Extra formats"

LICENSE="GPL-2 LPPL-1.3c"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc64 ~sparc ~x86"
