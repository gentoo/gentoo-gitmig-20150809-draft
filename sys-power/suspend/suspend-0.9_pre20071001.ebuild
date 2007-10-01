# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/suspend/suspend-0.9_pre20071001.ebuild,v 1.1 2007/10/01 07:45:41 alonbl Exp $

DESCRIPTION="Userspace Software Suspend and S2Ram"
HOMEPAGE="http://suspend.sourceforge.net/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="fbsplash"

X86_RDEPEND="dev-libs/libx86"
X86_DEPEND="
	${X86_RDEPEND}
	>=sys-apps/pciutils-2.2.4"
RDEPEND=">=dev-libs/lzo-2
	fbsplash? ( >=media-gfx/splashutils-1.5.2 )
	x86? ( ${X86_RDEPEND} )
	amd64? ( ${X86_RDEPEND} )"
DEPEND="${DEPEND}
	x86? ( ${X86_DEPEND} )
	amd64? ( ${X86_DEPEND} )
	dev-util/pkgconfig"

src_compile() {
	econf \
		--docdir="/usr/share/doc/${PF}" \
		--enable-compress \
		$(use_enable fbsplash) \
		|| die
	emake || die
}

src_install() {
	emake install DESTDIR="${D}" || die
}

pkg_postinst() {
	elog "In order to make this package work with genkernel see:"
	elog "http://bugs.gentoo.org/show_bug.cgi?id=156445"
}
