# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-mathextra/texlive-mathextra-2010.ebuild,v 1.6 2011/08/14 18:13:37 maekke Exp $

EAPI="3"

TEXLIVE_MODULE_CONTENTS="12many amstex binomexp boldtensors bosisio ccfonts circle commath concmath concrete extarrows extpfeil faktor ionumbers isomath mathcomp mattens mhequ multiobjective nath ot-tableau oubraces proba realscripts shuffle statex2 stmaryrd subsupscripts susy syllogism synproof tablor tensor tex-ewd thmbox turnstile unicode-math venn yhmath collection-mathextra
"
TEXLIVE_MODULE_DOC_CONTENTS="12many.doc amstex.doc binomexp.doc boldtensors.doc bosisio.doc ccfonts.doc circle.doc commath.doc concmath.doc concrete.doc extarrows.doc extpfeil.doc faktor.doc ionumbers.doc isomath.doc mathcomp.doc mattens.doc mhequ.doc multiobjective.doc nath.doc ot-tableau.doc oubraces.doc proba.doc realscripts.doc shuffle.doc stmaryrd.doc subsupscripts.doc susy.doc syllogism.doc synproof.doc tablor.doc tensor.doc tex-ewd.doc thmbox.doc turnstile.doc unicode-math.doc venn.doc yhmath.doc "
TEXLIVE_MODULE_SRC_CONTENTS="12many.source binomexp.source bosisio.source ccfonts.source concmath.source extpfeil.source faktor.source ionumbers.source mathcomp.source mattens.source multiobjective.source proba.source realscripts.source shuffle.source stmaryrd.source tensor.source thmbox.source turnstile.source unicode-math.source yhmath.source "
inherit texlive-module
DESCRIPTION="TeXLive Advanced math typesetting"

LICENSE="GPL-2 as-is BSD GPL-1 LGPL-2 LPPL-1.3 public-domain TeX "
SLOT="0"
KEYWORDS="~alpha amd64 arm ~hppa ~ia64 ~mips ppc ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd ~ppc-macos"
IUSE=""
DEPEND=">=dev-texlive/texlive-fontsrecommended-2010
>=dev-texlive/texlive-latex-2010
!<dev-texlive/texlive-latexextra-2010
"
RDEPEND="${DEPEND} "
