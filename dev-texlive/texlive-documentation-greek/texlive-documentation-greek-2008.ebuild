# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-documentation-greek/texlive-documentation-greek-2008.ebuild,v 1.10 2009/03/18 21:15:39 ranger Exp $

TEXLIVE_MODULE_CONTENTS="gentle-gr collection-documentation-greek
"
TEXLIVE_MODULE_DOC_CONTENTS="gentle-gr.doc "
TEXLIVE_MODULE_SRC_CONTENTS=""
inherit texlive-module
DESCRIPTION="TeXLive Greek documentation"

LICENSE="GPL-2 "
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""
DEPEND=">=dev-texlive/texlive-documentation-base-2008
"
RDEPEND="${DEPEND}"
