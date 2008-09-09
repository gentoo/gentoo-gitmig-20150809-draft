# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-documentation-chinese/texlive-documentation-chinese-2008.ebuild,v 1.1 2008/09/09 16:15:13 aballier Exp $

TEXLIVE_MODULES_DEPS="dev-texlive/texlive-documentation-base
"
TEXLIVE_MODULE_CONTENTS="texlive-zh-cn lnotes lshort-chinese collection-documentation-chinese
"
TEXLIVE_MODULE_DOC_CONTENTS="texlive-zh-cn.doc lnotes.doc lshort-chinese.doc "
TEXLIVE_MODULE_SRC_CONTENTS="texlive-zh-cn.source "
inherit texlive-module
DESCRIPTION="TeXLive Chinese documentation"

LICENSE="GPL-2 "
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""
