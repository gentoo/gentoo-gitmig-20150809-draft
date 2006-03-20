# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/db4o/db4o-5.0.ebuild,v 1.3 2006/03/20 00:47:46 metalgod Exp $

inherit mono multilib eutils

DESCRIPTION="Object database for .NET"
HOMEPAGE="http://www.db4o.com/"
SRC_URI="http://www.db4o.com/downloads/${P}-mono.tar.gz
	mirror://gentoo/${P}-makefile-filelist.diff"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lang/mono"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${DISTDIR}/${P}-makefile-filelist.diff
}

src_compile() {
	emake -j1 buildcore || die "emake failed"
}

src_install() {
	dohtml -a html,gif,js,css -r ${S}/doc/api

	# For now we don't install into the GAC, following upstream's RPM packaging.
	insinto /usr/$(get_libdir)/db4o
	doins ${S}/bin/db4o.dll*
}
