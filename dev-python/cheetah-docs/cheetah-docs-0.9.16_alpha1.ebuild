# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cheetah-docs/cheetah-docs-0.9.16_alpha1.ebuild,v 1.1 2005/02/12 11:32:32 kloeri Exp $

DESCRIPTION="Documentation for Cheetah templates."
HOMEPAGE="http://www.cheetahtemplate.org/"
SRC_URI="mirror://sourceforge/cheetahtemplate/CheetahDocs-${PV/_alpha/a}.tgz"

IUSE=""
LICENSE="PSF-2.2"
KEYWORDS="~x86 ~ppc"
SLOT="0"

DEPEND=""

S=${WORKDIR}/CheetahDocs

src_install() {
	dodoc *.ps *.pdf *.txt TODO
	dohtml -r devel_guide_html devel_guide_html_multipage
	dohtml -r users_guide_html users_guide_html_multipage
	dohtml OnePageTutorial.html

	# Install the source code.
	local srcdir=/usr/share/doc/${PF}
	dodir ${srcdir}
	mv devel_guide_src users_guide_src ${D}${srcdir}/
}
