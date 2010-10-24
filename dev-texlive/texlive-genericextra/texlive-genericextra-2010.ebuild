# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-genericextra/texlive-genericextra-2010.ebuild,v 1.1 2010/10/24 18:12:01 aballier Exp $

EAPI="3"

TEXLIVE_MODULE_CONTENTS="abbr abstyles barr borceux c-pascal colorsep dinat dirtree eijkhout encxvlna fenixpar fltpoint iftex insbox lecturer librarian mathdots metatex mftoeps midnight multi ofs pdf-trans shade tabto-generic texapi vrb xlop yax collection-genericextra
"
TEXLIVE_MODULE_DOC_CONTENTS="abbr.doc abstyles.doc barr.doc borceux.doc c-pascal.doc dinat.doc dirtree.doc encxvlna.doc fenixpar.doc fltpoint.doc iftex.doc insbox.doc lecturer.doc librarian.doc mathdots.doc metatex.doc midnight.doc ofs.doc pdf-trans.doc shade.doc texapi.doc vrb.doc xlop.doc yax.doc "
TEXLIVE_MODULE_SRC_CONTENTS="dirtree.source fltpoint.source mathdots.source mftoeps.source xlop.source "
inherit texlive-module
DESCRIPTION="TeXLive Extra generic packages"

LICENSE="GPL-2 as-is GPL-1 GPL-2 LPPL-1.3 public-domain TeX "
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""
DEPEND=">=dev-texlive/texlive-basic-2010
"
RDEPEND="${DEPEND} "
