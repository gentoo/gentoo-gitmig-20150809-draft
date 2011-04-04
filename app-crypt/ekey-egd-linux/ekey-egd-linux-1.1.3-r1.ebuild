# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/ekey-egd-linux/ekey-egd-linux-1.1.3-r1.ebuild,v 1.1 2011/04/04 12:20:55 flameeyes Exp $

EAPI=2

inherit eutils toolchain-funcs

MY_P="ekeyd-${PV}"
DESCRIPTION="EGD client from Entropy Key"
HOMEPAGE="http://www.entropykey.co.uk/"
SRC_URI="http://www.entropykey.co.uk/res/download/${MY_P}.tar.gz"

LICENSE="as-is" # yes, truly

SLOT="0"

KEYWORDS="~amd64 ~x86"

IUSE=""

RDEPEND=""
DEPEND=""

S="${WORKDIR}/${MY_P}"

src_prepare() {
	# avoid using -Werror
	sed -i -e 's:-Werror::' daemon/Makefile || die

	epatch "${FILESDIR}"/${P}-ldflags.patch
}

src_compile() {
	local osname

	# Override automatic detection: upstream provides this with uname,
	# we don't like using uname.
	case ${CHOST} in
		*-linux-*)
			osname=linux;;
		*-freebsd*)
			osname=freebsd;;
		*-kfrebsd-gnu)
			osname=gnukfreebsd;;
		*-openbsd*)
			osname=openbsd;;
		*)
			die "Unsupported operating system!"
			;;
	esac

	emake -C daemon \
		CC="$(tc-getCC)" \
		LUA_V= LUA_INC= \
		OSNAME=${osname} \
		OPT="${CFLAGS}" \
		egd-linux || die "emake failed"
}

src_install() {
	exeinto /usr/libexec
	newexe "${S}"/daemon/egd-linux ${PN} || die
	doman daemon/${PN}.8 || die

	newconfd "${FILESDIR}"/${PN}.conf ${PN} || die
	newinitd "${FILESDIR}"/${PN}.init ${PN} || die
}

pkg_postinst() {
	elog "Sysctl write support have to be enabled in order for the init script"
	elog "modify the kernel.random.write_wakeup_threshold sysctl entry."
}
