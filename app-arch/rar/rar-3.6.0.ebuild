# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/rar/rar-3.6.0.ebuild,v 1.5 2007/07/10 13:04:21 angelos Exp $

inherit toolchain-funcs

DESCRIPTION="RAR compressor/uncompressor"
HOMEPAGE="http://www.rarsoft.com/"
SRC_URI="http://www.rarlab.com/rar/rarlinux-${PV}.tar.gz"

LICENSE="RAR"
SLOT="0"
KEYWORDS="-* amd64 ~x86"
IUSE=""

RESTRICT="strip"

RDEPEND="sys-libs/glibc amd64? ( app-emulation/emul-linux-x86-compat )"

S="${WORKDIR}/${PN}"

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
	dosym /opt/rar/bin/rar /opt/bin/rar
	dosym /opt/rar/bin/unrar /opt/bin/unrar
}

pkg_postinst() {
	if [[ $(gcc-major-version) = "3" && $(gcc-minor-version) -lt 4 ]]; then
		ewarn "System gcc is too old to run $PN}."
		ewarn "${PN} requires >=sys-devel/gcc-3.4 to run."
	fi
}
