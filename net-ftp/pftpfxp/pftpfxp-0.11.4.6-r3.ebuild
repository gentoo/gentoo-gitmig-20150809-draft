# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/pftpfxp/pftpfxp-0.11.4.6-r3.ebuild,v 1.4 2009/01/03 13:25:02 angelos Exp $

inherit eutils toolchain-funcs

DESCRIPTION="The powerful curses-based ftp/fxp client, mew edition"
HOMEPAGE="http://pftpmew.tanesha.net"
SRC_URI="http://tanesha.net/bigmess/pftpfxp-v0.11.4mew6.tgz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="ssl"

DEPEND="ssl? ( >=dev-libs/openssl-0.9.6c )"

S="${WORKDIR}/pftpfxp-mew"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PV}-gcc3.4.fix || die "patch failed"
	epatch "${FILESDIR}"/pftpfxp-v0.11.4mew6-pret.patch || die "patch failed"
	epatch "${FILESDIR}"/${PV}-correct_config_fix.patch || die "patch failed"
	epatch "${FILESDIR}"/${PV}-correct_bookmark_path.patch || die "patch failed"
	sed -i -e "s/^CPP=.*/CPP=$(tc-getCXX)/" \
		-e "s:^CPPF=.*:CPPF=\"-Wall -D_REENTRANT -I../include ${CFLAGS}\":" \
		configure
}

src_compile() {
	#note: not a propper autoconf
	./configure || die "configure failed"
	emake DO=true || die "emake failed"
}

src_install() {
	dobin pftp || die "dobin failed"
	dodoc .pftp/config .pftp/keymap README.MEW old/*
	cd "${WORKDIR}"
	mv irssi  mIRC-mew  pftpfxp-autoconnect "${D}"/usr/share/doc/${PF}
}

pkg_postinst() {
	elog "In order to use pftp-mew you need to create these files:"
	elog "    ~/.pftp/config"
	elog "    ~/.pftp/keymap"
	elog "Refer to the examples in /usr/share/doc/${PF} for more information."
}
