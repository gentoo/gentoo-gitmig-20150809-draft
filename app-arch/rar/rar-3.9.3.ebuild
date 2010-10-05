# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/rar/rar-3.9.3.ebuild,v 1.1 2010/10/05 09:48:45 xmw Exp $

DESCRIPTION="RAR compressor/uncompressor"
HOMEPAGE="http://www.rarsoft.com/"
SRC_URI="x86? ( http://www.rarlab.com/rar/rarlinux-${PV}.tar.gz )
	amd64? ( http://www.rarlab.com/rar/rarlinux-x64-${PV}.tar.gz )"

LICENSE="RAR"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""

RDEPEND=">=sys-libs/glibc-2.4"

S=${WORKDIR}/${PN}

QA_DT_HASH="opt/rar/lib/default.sfx
	opt/rar/bin/unrar
	opt/rar/bin/rar"
QA_PRESTRIPPED="opt/rar/lib/default.sfx
	opt/rar/bin/unrar
	opt/rar/bin/rar"

src_compile() { :; }

src_install() {
	into /opt/rar
	dobin rar unrar || die
	insinto /opt/rar/lib
	doins default.sfx || die
	insinto /opt/rar/etc
	doins rarfiles.lst || die
	dodoc *.txt
	dodir /opt/bin
	dosym ../rar/bin/rar /opt/bin/rar
	dosym ../rar/bin/unrar /opt/bin/unrar
}
