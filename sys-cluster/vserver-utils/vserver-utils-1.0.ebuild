# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/vserver-utils/vserver-utils-1.0.ebuild,v 1.2 2006/04/10 12:03:22 phreak Exp $

inherit autotools eutils toolchain-funcs

DESCRIPTION="Linux-VServer admin utilities"
HOMEPAGE="http://dev.croup.de/proj/vserver-utils"
SRC_URI="http://dev.gentoo.org/~hollow/vserver-utils/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

DEPEND="=sys-libs/libvserver-1.0*"

pkg_setup() {
	if [[ -z "${VDIRBASE}" ]]; then
		einfo
		einfo "You can change the default vserver base directory (/vservers)"
		einfo "by setting the VDIRBASE environment variable."
	fi

	: ${VDIRBASE:=/vservers}

	einfo
	einfo "Using \"${VDIRBASE}\" as vserver base directory"
	einfo
}

src_compile() {
	econf --localstatedir=/var \
	      --with-initrddir=/etc/init.d \
	      --with-vdirbase="${VDIRBASE}" || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"

	keepdir "${VDIRBASE}"
	fperms 000 "${VDIRBASE}"

	dodoc README ChangeLog AUTHORS
}
