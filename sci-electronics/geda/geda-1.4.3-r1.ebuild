# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/geda/geda-1.4.3-r1.ebuild,v 1.1 2009/05/20 02:26:08 calchan Exp $

DESCRIPTION="Meta-package for the gEDA/gaf tools"
HOMEPAGE="http://www.gpleda.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="doc examples"

DEPEND="!<sci-electronics/geda-1.4.3-r1"
RDEPEND="=sci-libs/libgeda-${PV}*
	=sci-electronics/geda-gattrib-${PV}*
	=sci-electronics/geda-gnetlist-${PV}*
	=sci-electronics/geda-gschem-${PV}*
	=sci-electronics/geda-gsymcheck-${PV}*
	=sci-electronics/geda-symbols-${PV}*
	=sci-electronics/geda-utils-${PV}*
	doc? ( =sci-electronics/geda-docs-${PV}* )
	examples? ( =sci-electronics/geda-examples-${PV}* )"
