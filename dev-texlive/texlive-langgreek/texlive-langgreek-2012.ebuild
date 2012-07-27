# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-langgreek/texlive-langgreek-2012.ebuild,v 1.1 2012/07/27 02:11:48 aballier Exp $

EAPI="4"

TEXLIVE_MODULE_CONTENTS="betababel bgreek cbfonts gfsbaskerville gfsporson greek-inputenc greekdates greektex grverb ibycus-babel ibygrk kerkis levy lgreek lgrx mkgrkindex teubner xgreek yannisgr hyphen-greek hyphen-ancientgreek collection-langgreek
"
TEXLIVE_MODULE_DOC_CONTENTS="betababel.doc bgreek.doc cbfonts.doc gfsbaskerville.doc gfsporson.doc greek-inputenc.doc greekdates.doc greektex.doc grverb.doc ibycus-babel.doc ibygrk.doc kerkis.doc levy.doc lgreek.doc lgrx.doc mkgrkindex.doc teubner.doc xgreek.doc yannisgr.doc hyphen-greek.doc "
TEXLIVE_MODULE_SRC_CONTENTS="greekdates.source grverb.source ibycus-babel.source teubner.source xgreek.source "
inherit  texlive-module
DESCRIPTION="TeXLive Greek"

LICENSE="GPL-2 as-is GPL-1 GPL-2 LPPL-1.3 public-domain "
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""
DEPEND=">=dev-texlive/texlive-basic-2012
"
RDEPEND="${DEPEND} "
TEXLIVE_MODULE_BINSCRIPTS="texmf-dist/scripts/mkgrkindex/mkgrkindex"
