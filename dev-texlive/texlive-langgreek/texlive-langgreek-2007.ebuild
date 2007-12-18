# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-langgreek/texlive-langgreek-2007.ebuild,v 1.7 2007/12/18 19:57:43 jer Exp $

TEXLIVE_MODULES_DEPS="dev-texlive/texlive-basic
"
TEXLIVE_MODULE_CONTENTS="betababel cb greek greektex grtimes grverb hyphen-greek hyphen-ibycus ibycus ibycus-babel ibygrk kdgreek kerkis levy lgreek teubner yannisgr collection-langgreek
"
inherit texlive-module
DESCRIPTION="TeXLive Greek typesetting"

LICENSE="GPL-2 LPPL-1.3c"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc64 ~sparc ~x86"
