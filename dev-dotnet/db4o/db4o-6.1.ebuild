# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/db4o/db4o-6.1.ebuild,v 1.2 2010/10/07 18:49:53 pacho Exp $

inherit mono multilib eutils

DESCRIPTION="Object database for .NET"
HOMEPAGE="http://www.db4o.com/"
SRC_URI="http://www.db4o.com/downloads/${P}-mono.tar.gz"
#	mirror://gentoo/${P}-makefile-filelist.diff"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="dev-lang/mono"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-makefile.patch"
}

src_compile() {
#	emake -j1 buildcore || die "emake failed"
	emake -j1 || die "emake failed"
}

src_install() {

	if use doc; then
		emake DESTDIR="${D}" install || die "emake install failed"
	else
		# Prevents from installing documentation
		emake RPM_DOC_DIR="." DESTDIR="${D}" install || die "emake install failed"
	fi
}
