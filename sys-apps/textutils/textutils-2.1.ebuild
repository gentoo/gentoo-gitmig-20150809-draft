# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/textutils/textutils-2.1.ebuild,v 1.21 2004/07/15 02:40:56 agriffis Exp $

IUSE="nls static build"

DESCRIPTION="Standard GNU text utilities"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/textutils/"

KEYWORDS="x86 ppc sparc alpha mips hppa "
SLOT="0"
LICENSE="GPL-2"

DEPEND="nls? ( sys-devel/gettext )"

src_compile() {
	local myconf=""
	use nls || myconf="--disable-nls"

	econf \
		--build=${CHOST} \
		--without-included-regex \
		${myconf} || die

	if use static
	then
		emake LDFLAGS=-static || die
	else
		emake || die
	fi
}

src_install() {
	einstall || die

	dodir /bin
	mv ${D}/usr/bin/cat ${D}/bin
	dosym /bin/cat /usr/bin/cat
	# For baselayout
	mv ${D}/usr/bin/wc ${D}/bin
	dosym /bin/wc /usr/bin/wc

	rmdir ${D}/usr/lib

	if ! use build
	then
		dodoc AUTHORS COPYING ChangeLog NEWS README* THANKS TODO
	else
		rm -rf ${D}/usr/share
	fi
}
