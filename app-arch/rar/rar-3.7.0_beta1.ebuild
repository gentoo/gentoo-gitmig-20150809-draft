# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/rar/rar-3.7.0_beta1.ebuild,v 1.5 2007/07/02 13:38:24 peper Exp $

inherit toolchain-funcs

MY_PV=${PV/0_beta/b}
DESCRIPTION="RAR compressor/uncompressor"
HOMEPAGE="http://www.rarsoft.com/"
SRC_URI="http://www.rarlab.com/rar/rarlinux-${MY_PV}.tar.gz"

LICENSE="RAR"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE=""
RESTRICT="strip"

RDEPEND=">=sys-libs/glibc-2.4
	amd64? ( app-emulation/emul-linux-x86-compat )"

S=${WORKDIR}/${PN}

src_compile() { :; }

src_install() {
	into /opt/rar
	dobin rar unrar || die "dobin rar unrar"
	insinto /opt/rar/lib
	doins default.sfx || die "default.sfx"
	insinto /opt/rar/etc
	doins rarfiles.lst || die "rarfiles.lst"
	dodoc *.{txt,diz}
	dodir /opt/bin
	dosym ../rar/bin/rar /opt/bin/rar
	dosym ../rar/bin/unrar /opt/bin/unrar
	prepalldocs
}
