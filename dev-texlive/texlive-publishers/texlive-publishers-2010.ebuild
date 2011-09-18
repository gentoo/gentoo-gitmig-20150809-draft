# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-publishers/texlive-publishers-2010.ebuild,v 1.6 2011/09/18 17:24:57 armin76 Exp $

EAPI="3"

TEXLIVE_MODULE_CONTENTS="ANUfinalexam IEEEconf IEEEtran aastex acmconf acmtrans active-conf afthesis aguplus aiaa ametsoc apa arsclassica asaetr ascelike beamer-FUBerlin chem-journal classicthesis confproc ebsthesis economic elbioimp elsevier elteikthesis erdc estcpmm euproposal gaceta gatech-thesis har2nat icsv ieeepes ijmart imac imtekda jhep jmlr jpsj kluwer lps macqassign mentis muthesis nature nddiss nih nostarch nrc onrannual philosophersimprint powerdot-FUBerlin pracjourn procIAGssymp ptptex psu-thesis revtex revtex4 ryethesis sageep seuthesis siggraph soton spie stellenbosch suftesi sugconf texilikechaps texilikecover thesis-titlepage-fhac thuthesis toptesi tugboat tugboat-plain uaclasses ucdavisthesis ucthesis uiucthesis umthesis umich-thesis ut-thesis uowthesis uwthesis vancouver vxu york-thesis collection-publishers
"
TEXLIVE_MODULE_DOC_CONTENTS="ANUfinalexam.doc IEEEconf.doc IEEEtran.doc aastex.doc acmconf.doc acmtrans.doc active-conf.doc afthesis.doc aguplus.doc aiaa.doc ametsoc.doc apa.doc arsclassica.doc asaetr.doc ascelike.doc beamer-FUBerlin.doc classicthesis.doc confproc.doc ebsthesis.doc economic.doc elbioimp.doc elsevier.doc elteikthesis.doc erdc.doc estcpmm.doc euproposal.doc gaceta.doc gatech-thesis.doc har2nat.doc icsv.doc ieeepes.doc ijmart.doc imac.doc imtekda.doc jmlr.doc jpsj.doc kluwer.doc lps.doc macqassign.doc mentis.doc muthesis.doc nature.doc nddiss.doc nih.doc nostarch.doc nrc.doc onrannual.doc philosophersimprint.doc powerdot-FUBerlin.doc pracjourn.doc procIAGssymp.doc ptptex.doc psu-thesis.doc revtex.doc revtex4.doc ryethesis.doc sageep.doc seuthesis.doc siggraph.doc soton.doc spie.doc stellenbosch.doc suftesi.doc sugconf.doc thesis-titlepage-fhac.doc thuthesis.doc toptesi.doc tugboat.doc tugboat-plain.doc uaclasses.doc ucdavisthesis.doc ucthesis.doc uiucthesis.doc umthesis.doc umich-thesis.doc ut-thesis.doc uowthesis.doc uwthesis.doc vancouver.doc vxu.doc york-thesis.doc "
TEXLIVE_MODULE_SRC_CONTENTS="IEEEconf.source aastex.source acmconf.source active-conf.source aiaa.source confproc.source ebsthesis.source elbioimp.source elteikthesis.source erdc.source estcpmm.source euproposal.source icsv.source ijmart.source imtekda.source jmlr.source kluwer.source lps.source mentis.source nddiss.source nostarch.source nrc.source philosophersimprint.source pracjourn.source revtex.source revtex4.source ryethesis.source sageep.source seuthesis.source siggraph.source stellenbosch.source thesis-titlepage-fhac.source thuthesis.source toptesi.source tugboat.source uaclasses.source ucdavisthesis.source uiucthesis.source vxu.source york-thesis.source "
inherit texlive-module
DESCRIPTION="TeXLive Support for publishers, theses, standards, conferences, etc."

LICENSE="GPL-2 Apache-2.0 as-is GPL-1 GPL-3 LPPL-1.2 LPPL-1.3 public-domain "
SLOT="0"
KEYWORDS="alpha amd64 arm ~hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""
DEPEND=">=dev-texlive/texlive-latex-2010
!<dev-texlive/texlive-latexextra-2010
"
RDEPEND="${DEPEND} "
