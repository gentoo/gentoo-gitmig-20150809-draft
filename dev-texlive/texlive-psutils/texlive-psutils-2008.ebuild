# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-psutils/texlive-psutils-2008.ebuild,v 1.1 2008/09/09 16:52:44 aballier Exp $

TEXLIVE_MODULES_DEPS=""
TEXLIVE_MODULE_CONTENTS="dvipsconfig bin-getafm bin-pstools bin-psutils bin-t1utils collection-psutils
"
TEXLIVE_MODULE_DOC_CONTENTS="bin-getafm.doc bin-pstools.doc bin-psutils.doc bin-t1utils.doc "
TEXLIVE_MODULE_SRC_CONTENTS=""
inherit texlive-module
DESCRIPTION="TeXLive Extra font utilities"

LICENSE="GPL-2 GPL-1 LPPL-1.3 public-domain "
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""
