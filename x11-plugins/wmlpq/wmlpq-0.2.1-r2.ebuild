# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmlpq/wmlpq-0.2.1-r2.ebuild,v 1.1 2011/05/19 19:11:04 c1pher Exp $

inherit eutils flag-o-matic toolchain-funcs

IUSE=""

DESCRIPTION="Windowmaker dockapp which monitors up to 5 printqueues"
SRC_URI="http://www.ur.uklinux.net/wmlpq/dl/wmlpq_0.2.1.tar.gz"
HOMEPAGE="http://www.ur.uklinux.net/wmlpq/"

DEPEND="x11-libs/libdockapp"

RDEPEND=""

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~ppc ~x86"

src_unpack()
{
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PN}-makefile-ldflags.patch"
}

src_compile()
{
	append-ldflags "-L/usr/X11R6/lib -L/usr/local/lib"
	emake CC=$(tc-getCC) LDFLAGS="${LDFLAGS}" || die
}

src_install()
{
	dodir /usr/bin || die
	emake DESTDIR="${D}/usr/bin" install || die "Installation failed"

	dodoc README sample.wmlpqrc || die
	newman wmlpq.1x wmlpq.1 || die

	insinto /usr/share/applications
	doins "${FILESDIR}/${PN}.desktop" || die
}
