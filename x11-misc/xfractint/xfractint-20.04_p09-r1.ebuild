# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xfractint/xfractint-20.04_p09-r1.ebuild,v 1.1 2010/09/30 10:50:53 spock Exp $

EAPI=2

inherit eutils toolchain-funcs

MY_P=${P/_}

DESCRIPTION="a fractal generator"
HOMEPAGE="http://www.fractint.org"
SRC_URI="http://www.fractint.org/ftp/current/linux/${MY_P}.tar.gz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="x11-libs/libX11"
DEPEND="${RDEPEND}"
#	x86? ( dev-lang/nasm )"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${FILESDIR}/xfractint-20.04p09-ldflags.patch"
}

src_compile() {
	# Untested, any x86 archteam dev. is allowed to uncomment this.
	local myasm="foo"
#	use x86 && myasm="/usr/bin/nasm"
	emake CC="$(tc-getCC)" AS="${myasm}" OPT="${CFLAGS}" LDFLAGS="${LDFLAGS}" || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}/usr" STRIP="true" install || die "emake install failed."
	newenvd "${FILESDIR}"/xfractint.envd 60xfractint
}

pkg_postinst() {
	elog "XFractInt requires the FRACTDIR variable to be set in order to start."
	elog "Please re-login or \`source /etc/profile\` to have this variable set."
}
