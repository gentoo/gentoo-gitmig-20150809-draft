# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-xetex/texlive-xetex-2010.ebuild,v 1.2 2010/10/30 17:22:00 aballier Exp $

EAPI="3"

TEXLIVE_MODULE_CONTENTS="arabxetex euenc fontspec fontwrap harvardkyoto mathspec philokalia polyglossia xecjk xecolour xecyr xeindex xepersian xesearch xetex xetex-def xetex-itrans xetex-pstricks xetexconfig xetexfontinfo xltxtra xunicode collection-xetex
"
TEXLIVE_MODULE_DOC_CONTENTS="arabxetex.doc euenc.doc fontspec.doc fontwrap.doc mathspec.doc philokalia.doc polyglossia.doc xecjk.doc xecolour.doc xecyr.doc xeindex.doc xepersian.doc xesearch.doc xetex.doc xetex-itrans.doc xetex-pstricks.doc xetexfontinfo.doc xltxtra.doc xunicode.doc "
TEXLIVE_MODULE_SRC_CONTENTS="arabxetex.source euenc.source fontspec.source philokalia.source polyglossia.source xecjk.source xltxtra.source "
inherit texlive-module
DESCRIPTION="TeXLive XeTeX packages"

LICENSE="GPL-2 Apache-2.0 as-is GPL-1 LPPL-1.3 OFL public-domain "
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""
DEPEND=">=dev-texlive/texlive-basic-2010
!=app-text/texlive-core-2007*
dev-texlive/texlive-latexextra
>=dev-texlive/texlive-latex3-2010
>=app-text/texlive-core-2010[xetex]
"
RDEPEND="${DEPEND} "
