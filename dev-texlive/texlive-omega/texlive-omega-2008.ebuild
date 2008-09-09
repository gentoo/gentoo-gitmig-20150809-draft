# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-omega/texlive-omega-2008.ebuild,v 1.1 2008/09/09 16:50:28 aballier Exp $

TEXLIVE_MODULES_DEPS="dev-texlive/texlive-basic
"
TEXLIVE_MODULE_CONTENTS="antomega lambda mxd mxedruli omega bin-aleph bin-omega bin-omegaware collection-omega
"
TEXLIVE_MODULE_DOC_CONTENTS="antomega.doc mxd.doc mxedruli.doc omega.doc bin-omega.doc bin-omegaware.doc "
TEXLIVE_MODULE_SRC_CONTENTS="antomega.source mxd.source "
inherit texlive-module
DESCRIPTION="TeXLive Omega"

LICENSE="GPL-2 freedist GPL-1 LPPL-1.3 "
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""
