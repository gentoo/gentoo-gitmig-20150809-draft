# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/adesklets/adesklets-0.4.5.ebuild,v 1.2 2005/03/21 08:26:04 s4t4n Exp $

DESCRIPTION="An interactive Imlib2 console for the X Window system"
HOMEPAGE="http://adesklets.sf.net/"
SRC_URI="mirror://sourceforge/adesklets/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~amd64"
IUSE="X python"

DEPEND="virtual/libc
	>=sys-libs/readline-4.3-r5
	>=media-libs/imlib2-1.2.0-r2
	X? (virtual/x11)
	python? (>=dev-lang/python-2.3.4-r1)"

src_compile()
{
	local myconf=""

	use X || myconf="--without-x"
	use python || myconf="${myconf} --without-python-support"

	econf ${myconf} || die
	emake || die
}

src_install()
{
	make DESTDIR=${D} install || die
	doinfo doc/adesklets_en.info doc/adesklets_fr.info
	doman doc/adesklets.1
	dodoc ChangeLog INSTALL NEWS TODO AUTHORS
	dohtml -r doc/html/*
}

pkg_postinst()
{
	use X ||
	{
		ewarn "You did not install the X Window support for ${P}"
		ewarn "If you intend to use it to display desklets, this"
		ewarn "is a mistake."
		ewarn
		ewarn "Type USE=\"X\" emerge adesklets to correct this."
		ewarn
		einfo "Please also note that if it is what you intended"
		einfo "to do, you need also to install imlib2 without"
		einfo "X support to effectively remove all dependencies."
		einfo
	}

	use python ||
	{
		ewarn "You did not install the python bindings for ${P}"
		ewarn "If you intend to use it to display desklets, this"
		ewarn "is most probably an error."
		ewarn
		ewarn "Type USE=\"python\" emerge adesklets to correct this."
	}
}
