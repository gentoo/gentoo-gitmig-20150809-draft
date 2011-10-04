# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-latexrecommended/texlive-latexrecommended-2010.ebuild,v 1.10 2011/10/04 18:37:02 jer Exp $

EAPI="3"

TEXLIVE_MODULE_CONTENTS="anysize  booktabs caption cite citeref cmap crop ctable ec eso-pic euler extsizes fancybox fancyref fancyvrb float fp index jknapltx koma-script listings mdwtools memoir metalogo microtype ms ntgclass parskip pdfpages powerdot psfrag rcs rotating sansmath seminar setspace subfig thumbpdf typehtml underscore url  xkeyval collection-latexrecommended
"
TEXLIVE_MODULE_DOC_CONTENTS="anysize.doc booktabs.doc caption.doc cite.doc cmap.doc crop.doc ctable.doc ec.doc eso-pic.doc euler.doc extsizes.doc fancybox.doc fancyref.doc fancyvrb.doc float.doc fp.doc index.doc jknapltx.doc listings.doc mdwtools.doc memoir.doc metalogo.doc microtype.doc ms.doc ntgclass.doc parskip.doc pdfpages.doc powerdot.doc psfrag.doc rcs.doc rotating.doc sansmath.doc seminar.doc subfig.doc thumbpdf.doc typehtml.doc underscore.doc url.doc xkeyval.doc "
TEXLIVE_MODULE_SRC_CONTENTS="booktabs.source caption.source crop.source ctable.source eso-pic.source euler.source fancyref.source fancyvrb.source float.source index.source listings.source mdwtools.source memoir.source metalogo.source microtype.source ms.source ntgclass.source pdfpages.source powerdot.source psfrag.source rcs.source rotating.source subfig.source typehtml.source xkeyval.source "
inherit  texlive-module
DESCRIPTION="TeXLive LaTeX recommended packages"

LICENSE="GPL-2 as-is GPL-1 LPPL-1.2 LPPL-1.3 public-domain "
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""
DEPEND=">=dev-texlive/texlive-latex-2010
!dev-tex/xkeyval
!dev-tex/memoir
!dev-tex/listings
!=dev-texlive/texlive-latexextra-2007*
!=app-text/texlive-core-2007*
!=dev-texlive/texlive-xetex-2008
"
RDEPEND="${DEPEND} "
TEXLIVE_MODULE_BINSCRIPTS="texmf-dist/scripts/thumbpdf/thumbpdf.pl"
PATCHES=( "${FILESDIR}/thumbpdf_invocation.patch" )
