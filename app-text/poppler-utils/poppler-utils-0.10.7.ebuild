# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/poppler-utils/poppler-utils-0.10.7.ebuild,v 1.5 2009/06/16 20:27:11 klausman Exp $

EAPI=2

POPPLER_MODULE=utils

inherit poppler

DESCRIPTION="PDF conversion utilities"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd"
IUSE="+abiword"

RDEPEND="
	~dev-libs/poppler-${PV}[abiword?]
	abiword? ( >=dev-libs/libxml2-2.7.2 )
	!app-text/pdftohtml
	"
DEPEND="
	${RDEPEND}
	"

pkg_setup() {
	POPPLER_CONF="$(use_enable abiword abiword-output)"
}
