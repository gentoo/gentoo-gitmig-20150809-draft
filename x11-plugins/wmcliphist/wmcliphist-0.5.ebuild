# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmcliphist/wmcliphist-0.5.ebuild,v 1.8 2004/07/20 11:02:20 s4t4n Exp $

inherit eutils

IUSE=""
DESCRIPTION="Dockable clipboard history application for Window Maker"
HOMEPAGE="http://linux.nawebu.cz/wmcliphist/"
SRC_URI="http://linux.nawebu.cz/wmcliphist/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="x86 amd64 ~sparc ppc"
SLOT="0"

DEPEND="=x11-libs/gtk+-1.2*"

src_unpack()
{
	unpack ${A}
	cd ${S}

	# We patch the Makefile as the original doesn't honour Gentoo CFLAGS
	epatch ${FILESDIR}/wmcliphist-cflags.patch || die "Source patch failed."
}

src_compile()
{
	emake GENTOO_CFLAGS="${CFLAGS}" || die "Compilation failed."
}

src_install()
{
	dobin wmcliphist
	dodoc ChangeLog README
	newdoc .wmcliphistrc wmcliphistrc.sample
}
