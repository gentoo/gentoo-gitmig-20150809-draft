# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/detect/detect-0.9.72.ebuild,v 1.9 2004/10/10 02:31:27 vapier Exp $

inherit eutils

DESCRIPTION="library for automatic hardware detection"
HOMEPAGE="http://www.mandrakelinux.com/harddrake/index.php"
SRC_URI="mirror://debian/pool/main/d/detect/${P//-/_}.orig.tar.gz
	mirror://debian/pool/main/d/detect/${P//-/_}-6.1.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/libc"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${WORKDIR}/${P//-/_}-6.1.diff
	chmod a+rx configure config.sub config.guess
	sed -i '/include.*genhd\.h/s:.*::' src/{detect.h,disk.c}
}

src_compile() {
	econf --with-kernel-source="${ROOT}/usr" || die
	emake || die
}

src_install() {
	make \
		DESTDIR="${D}" \
		localedir="${D}/usr/share/locale" \
		gnulocaledir="${D}/usr/share/locale" \
		install || die
}

