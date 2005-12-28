# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/xmlindent/xmlindent-0.2.17.ebuild,v 1.1 2005/12/28 13:35:30 slarti Exp $

inherit eutils
DESCRIPTION="XML Indent is an XML stream reformatter written in ANSI C, analogous to GNU indent."
HOMEPAGE="http://xmlindent.sourceforge.net/"
SRC_URI="mirror://sourceforge/xmlindent/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc"

IUSE=""
DEPEND="sys-devel/flex"


src_compile() {
	emake || die "emake failed"
}

src_install() {
	dobin xmlindent
	doman *.1
}

