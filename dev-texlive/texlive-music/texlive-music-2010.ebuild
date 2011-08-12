# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-music/texlive-music-2010.ebuild,v 1.4 2011/08/12 15:58:36 xarthisius Exp $

EAPI="3"

TEXLIVE_MODULE_CONTENTS="abc figbas gchords guitar harmony musictex musixlyr musixps musixtex songbook musixflx collection-music
"
TEXLIVE_MODULE_DOC_CONTENTS="abc.doc gchords.doc guitar.doc harmony.doc musictex.doc musixlyr.doc musixps.doc musixtex.doc songbook.doc "
TEXLIVE_MODULE_SRC_CONTENTS="abc.source guitar.source songbook.source "
inherit texlive-module
DESCRIPTION="TeXLive Music typesetting"

LICENSE="GPL-2 as-is GPL-1 LGPL-2.1 LPPL-1.3 "
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ppc ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd"
IUSE=""
DEPEND=">=dev-texlive/texlive-latex-2010
"
RDEPEND="${DEPEND} "
