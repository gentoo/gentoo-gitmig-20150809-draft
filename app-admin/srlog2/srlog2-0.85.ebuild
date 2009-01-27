# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/srlog2/srlog2-0.85.ebuild,v 1.1 2009/01/27 20:40:43 bangert Exp $

inherit toolchain-funcs

DESCRIPTION="Secure Remote Log transmission system"
HOMEPAGE="http://untroubled.org/srlog2/"
SRC_URI="http://untroubled.org/srlog2/archive/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=dev-libs/bglibs-1.104
		app-crypt/nistp224
		>=dev-libs/libtomcrypt-1.03"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	echo -n "$(tc-getCC) ${CFLAGS}" > conf-cc
	echo -n "$(tc-getCC) ${LDFLAGS}" > conf-ld
	echo -n "/usr/include/bglibs" > conf-bgincs
	echo -n "/usr/lib/bglibs" > conf-bglibs
	echo -n /usr/bin > conf-bin
	echo -n /usr/share/man > conf-man

	# Deliberatly don't fix curve25519 as its full of PIC unfriendly asm code
	# uncomment and follow
	# http://www.gentoo.org/proj/en/hardened/pic-fix-guide.xml (Thunk it in
	# assembly) to fix curve25519/*.s

	sed -i -e 's/x86cpuid /x86cpuid -fno-pie /' curve25519/curve25519.impl.do
	sed -i -e 's/) >/) -fPIC >/g' curve25519/Makefile
	#If this isn't fixed it just includes app-crypt/nistp224 support only
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	emake install_prefix="${D}" install || die "emake install failed"
	dodoc ANNOUNCEMENT NEWS README *.html
}

pkg_postinst() {
	# even with the pic code fixed this only works on 32 bit cpus
	#elog 'curve25519 only works on 32-bit x86 systems at the moment'
	elog 'curve25519 support is currenly broken'
}
