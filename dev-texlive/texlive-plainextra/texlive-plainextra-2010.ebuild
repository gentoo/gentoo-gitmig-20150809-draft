# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-plainextra/texlive-plainextra-2010.ebuild,v 1.6 2011/08/14 18:18:54 maekke Exp $

EAPI="3"

TEXLIVE_MODULE_CONTENTS="figflow fixpdfmag font-change fontch graphics-pln hyplain js-misc mkpattern newsletr pitex placeins-plain plnfss present resumemac timetable treetex varisize collection-plainextra
"
TEXLIVE_MODULE_DOC_CONTENTS="figflow.doc font-change.doc fontch.doc graphics-pln.doc hyplain.doc js-misc.doc mkpattern.doc newsletr.doc pitex.doc plnfss.doc present.doc resumemac.doc treetex.doc varisize.doc "
TEXLIVE_MODULE_SRC_CONTENTS="graphics-pln.source "
inherit texlive-module
DESCRIPTION="TeXLive Plain TeX supplementary packages"

LICENSE="GPL-2 as-is LPPL-1.3 public-domain "
SLOT="0"
KEYWORDS="~alpha amd64 arm ~hppa ~ia64 ~mips ppc ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd ~ppc-macos"
IUSE=""
DEPEND=">=dev-texlive/texlive-basic-2010
!<dev-texlive/texlive-langvietnamese-2009
"
RDEPEND="${DEPEND} "
