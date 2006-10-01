# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/conf-update/conf-update-0.12.0.ebuild,v 1.3 2006/10/01 14:33:11 kugelfang Exp $

inherit toolchain-funcs

DESCRIPTION="${PN} is a ncurses-based config management utility"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2 http://dev.gentoo.org/~blubb/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~x86"
IUSE="colordiff"

RDEPEND=">=dev-libs/glib-2.6
		dev-libs/openssl
		sys-libs/ncurses
		colordiff? ( app-misc/colordiff )"
DEPEND="dev-util/pkgconfig
		${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i -e "s/\$Rev:.*\\$/${PVR}/" conf-update.h || die 'version-sed failed'

	# gcc-4.1-only option
	sed -i -e "s:-Wno-pointer-sign::g" Makefile || die 'gcc-sed failed'

	if use colordiff ; then
		sed -i -e "s/diff_tool=diff/diff_tool=colordiff/" ${PN}.conf || \
			die 'version-sed failed'
	fi
}

src_compile() {
	emake CC=$(tc-getCC) || die 'emake failed'
}

src_install() {
	into /usr
	dosbin ${PN} || die 'dosbin failed'

	insinto /etc
	doins ${PN}.conf

	doman ${PN}.1
}

pkg_postinst() {
	if has_version '<app-portage/conf-update-0.12.0' ; then
		ewarn "Note that the format for /etc/conf-update.conf changed in this"
		ewarn "version. You should merge the update of that file with e.g."
		ewarn "etc-update."
	fi
}
