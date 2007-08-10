# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/ntfs3g/ntfs3g-1.810.ebuild,v 1.1 2007/08/10 14:49:55 chutzpah Exp $

inherit multilib toolchain-funcs

MY_PN="${PN/3g/-3g}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Open source read-write NTFS driver that runs under FUSE"
HOMEPAGE="http://www.ntfs-3g.org"
SRC_URI="http://www.ntfs-3g.org/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="suid"

RDEPEND=">=sys-fs/fuse-2.6.3"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S="${WORKDIR}/${MY_P}"

src_compile() {
	econf --disable-ldconfig --libdir=/$(get_libdir)
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"

	dodir /usr/$(get_libdir)/
	mv "${D}"/$(get_libdir)/*.{,l}a "${D}"/usr/$(get_libdir)/

	dodoc AUTHORS ChangeLog CREDITS NEWS README

	gen_usr_ldscript libntfs-3g.so

	use suid && fperms u+s /bin/${MY_PN}
}

pkg_postinst() {
	if use suid; then
		ewarn
		ewarn "You have chosen to install ${PN} with the binary setuid root. This"
		ewarn "means that if there any undetected vulnerabilities in the binary,"
		ewarn "then local users may be able to gain root access on your machine."
		ewarn
	fi
}
