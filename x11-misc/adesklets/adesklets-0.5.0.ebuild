# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/adesklets/adesklets-0.5.0.ebuild,v 1.2 2006/01/15 16:05:12 nelchael Exp $

DESCRIPTION="An interactive Imlib2 console for the X Window system"
HOMEPAGE="http://adesklets.sf.net/"
SRC_URI="mirror://sourceforge/adesklets/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc x86"
IUSE="X python"

DEPEND=">=media-libs/imlib2-1.2.0-r2
	X? ( || ( (
			x11-libs/libX11
			x11-libs/libXt
			x11-proto/xproto )
		virtual/x11 ) )
	python? ( >=dev-lang/python-2.3.4-r1 )"

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
	dodir usr/share/info
	dodir usr/share/man/man1
	make DESTDIR=${D} install || die
	doinfo doc/*.info || die "info page installation failed"
	doman doc/*.1 || die "man page installation failed"
	dodoc ChangeLog NEWS TODO AUTHORS
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
