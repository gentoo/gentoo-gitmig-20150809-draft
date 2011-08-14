# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-pictures/texlive-pictures-2010-r1.ebuild,v 1.11 2011/08/14 18:18:01 maekke Exp $

EAPI="3"

TEXLIVE_MODULE_CONTENTS="asyfig autoarea bardiag cachepic chemfig combinedgraphics circuitikz curve curve2e curves dcpic diagmac2 doc-pictex dottex  dratex drs duotenzor eepic epspdf epspdfconversion esk fig4latex gnuplottex here hvfloat knitting knittingpattern mathspic miniplot numericplots pb-diagram petri-nets  pgf-soroban pgf-umlsd pgfopts pgfplots picinpar pict2e pictex pictex2 pinlabel pmgraph prerex randbild roundbox schemabloc swimgraf texdraw tikz-3dplot tikz-inet tikz-qtree tikz-timing tkz-doc tkz-linknodes tkz-orm tkz-tab tufte-latex xypdf xypic collection-pictures
"
TEXLIVE_MODULE_DOC_CONTENTS="asyfig.doc autoarea.doc bardiag.doc cachepic.doc chemfig.doc combinedgraphics.doc circuitikz.doc curve.doc curve2e.doc curves.doc dcpic.doc diagmac2.doc doc-pictex.doc dottex.doc dratex.doc drs.doc duotenzor.doc eepic.doc epspdf.doc epspdfconversion.doc esk.doc fig4latex.doc gnuplottex.doc here.doc hvfloat.doc knitting.doc knittingpattern.doc mathspic.doc miniplot.doc numericplots.doc pb-diagram.doc petri-nets.doc pgf-soroban.doc pgf-umlsd.doc pgfopts.doc pgfplots.doc picinpar.doc pict2e.doc pictex.doc pinlabel.doc pmgraph.doc prerex.doc randbild.doc roundbox.doc schemabloc.doc swimgraf.doc texdraw.doc tikz-3dplot.doc tikz-inet.doc tikz-qtree.doc tikz-timing.doc tkz-doc.doc tkz-linknodes.doc tkz-orm.doc tkz-tab.doc tufte-latex.doc xypdf.doc xypic.doc "
TEXLIVE_MODULE_SRC_CONTENTS="asyfig.source combinedgraphics.source curve.source curve2e.source curves.source dottex.source esk.source gnuplottex.source petri-nets.source pgfopts.source pgfplots.source pict2e.source randbild.source tikz-timing.source "
inherit  texlive-module
DESCRIPTION="TeXLive Graphics packages and programs"

LICENSE="GPL-2 Apache-2.0 as-is GPL-1 GPL-3 LPPL-1.3 public-domain "
SLOT="0"
KEYWORDS="~alpha amd64 arm ~hppa ~ia64 ~mips ppc ppc64 ~s390 ~sh ~sparc x86 ~ppc-macos"
IUSE=""
DEPEND=">=dev-texlive/texlive-basic-2010
!<dev-texlive/texlive-latexextra-2009
!<dev-texlive/texlive-texinfo-2009
"
RDEPEND="${DEPEND} dev-lang/ruby
"
TEXLIVE_MODULE_BINSCRIPTS="texmf-dist/scripts/cachepic/cachepic.tlu texmf-dist/scripts/epspdf/epspdf texmf-dist/scripts/epspdf/epspdftk texmf-dist/scripts/fig4latex/fig4latex texmf-dist/scripts/mathspic/mathspic.pl"
