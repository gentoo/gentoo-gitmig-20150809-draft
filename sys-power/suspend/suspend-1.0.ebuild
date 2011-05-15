# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/suspend/suspend-1.0.ebuild,v 1.2 2011/05/15 20:49:06 xmw Exp $

EAPI=2

inherit autotools eutils

DESCRIPTION="Userspace Software Suspend and S2Ram"
HOMEPAGE="http://suspend.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P/-/-utils-}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="fbsplash crypt threads"

X86_RDEPEND="dev-libs/libx86"
X86_DEPEND="
	${X86_RDEPEND}
	>=sys-apps/pciutils-2.2.4"
RDEPEND=">=dev-libs/lzo-2[static-libs]
	fbsplash? ( >=media-gfx/splashutils-1.5.2 )
	crypt? ( dev-libs/libgcrypt[static-libs]
		dev-libs/libgpg-error[static-libs] )
	x86? ( ${X86_RDEPEND} )
	amd64? ( ${X86_RDEPEND} )"
DEPEND="${RDEPEND}
	x86? ( ${X86_DEPEND} )
	amd64? ( ${X86_DEPEND} )
	dev-util/pkgconfig"

S="${WORKDIR}/${P/-/-utils-}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-errno.patch
}

src_configure() {
	econf \
		--docdir="/usr/share/doc/${PF}" \
		--enable-compress \
		$(use_enable crypt encrypt) \
		$(use_enable fbsplash) \
		$(use_enable threads) \
		|| die
}

src_install() {
	emake install DESTDIR="${D}" || die
}

pkg_postinst() {
	elog "In order to make this package work with genkernel see:"
	elog "http://bugs.gentoo.org/show_bug.cgi?id=156445"
}
