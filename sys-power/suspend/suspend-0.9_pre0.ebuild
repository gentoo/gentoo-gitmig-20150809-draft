# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/suspend/suspend-0.9_pre0.ebuild,v 1.1 2010/10/03 20:29:33 xmw Exp $

EAPI=2

inherit autotools eutils

# Name based on the git tag from which the tarball was created
MY_GIT_SHORT_COMMIT=9a5329f
MY_P=suspend-utils-${MY_GIT_SHORT_COMMIT}
DESCRIPTION="Userspace Software Suspend and S2Ram"
HOMEPAGE="http://suspend.sourceforge.net/"
SRC_URI="http://xmw.de/mirror/${PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="fbsplash crypt"

X86_RDEPEND="dev-libs/libx86"
X86_DEPEND="
	${X86_RDEPEND}
	>=sys-apps/pciutils-2.2.4"
RDEPEND=">=dev-libs/lzo-2
	fbsplash? ( >=media-gfx/splashutils-1.5.2 )
	crypt? ( dev-libs/libgcrypt )
	x86? ( ${X86_RDEPEND} )
	amd64? ( ${X86_RDEPEND} )"
DEPEND="${RDEPEND}
	x86? ( ${X86_DEPEND} )
	amd64? ( ${X86_DEPEND} )
	dev-util/pkgconfig"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	sed -i -e "/AC_INIT/s/0\.8/0.9-${MY_GIT_SHORT_COMMIT}/" configure.ac || die
	eautoreconf
}

src_configure() {
	econf \
		--docdir="/usr/share/doc/${PF}" \
		--enable-compress \
		$(use_enable crypt encrypt) \
		$(use_enable fbsplash) \
		|| die
}

src_install() {
	emake install DESTDIR="${D}" || die
}

pkg_postinst() {
	elog "In order to make this package work with genkernel see:"
	elog "http://bugs.gentoo.org/show_bug.cgi?id=156445"
}
