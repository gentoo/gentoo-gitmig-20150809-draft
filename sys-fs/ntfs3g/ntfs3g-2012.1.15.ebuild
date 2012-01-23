# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/ntfs3g/ntfs3g-2012.1.15.ebuild,v 1.1 2012/01/23 18:32:01 chutzpah Exp $

EAPI=2
inherit linux-info

MY_PN="${PN/3g/-3g}"
MY_P="${MY_PN}_ntfsprogs-${PV}"

DESCRIPTION="Open source read-write NTFS driver that runs under FUSE"
HOMEPAGE="http://www.tuxera.com/community/ntfs-3g-download/"
SRC_URI="http://tuxera.com/opensource/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~sparc ~x86"
IUSE="acl crypt debug extras ntfsprogs suid static-libs xattr +udev +external-fuse"

RDEPEND="external-fuse? ( >=sys-fs/fuse-2.8.0 )
	ntfsprogs? ( !!sys-fs/ntfsprogs )
	crypt? ( net-libs/gnutls )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-apps/attr"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	if use external-fuse && use kernel_linux; then
		if kernel_is lt 2 6 9; then
			die "Your kernel is too old."
		fi
		CONFIG_CHECK="~FUSE_FS"
		FUSE_FS_WARNING="You need to have FUSE module built to use ntfs-3g"
		linux-info_pkg_setup
	fi
}

src_configure() {
	econf \
		--docdir="/usr/share/doc/${PF}" \
		--enable-ldscript \
		--disable-ldconfig \
		--with-fuse=$(use external-fuse && echo external || echo internal) \
		$(use_enable acl posix-acls) \
		$(use_enable crypt crypto) \
		$(use_enable extras) \
		$(use_enable ntfsprogs) \
		$(use_enable static-libs static) \
		$(use_enable xattr xattr-mappings)	\
		$(use_enable debug)
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"

	dodoc AUTHORS ChangeLog CREDITS README

	use suid && fperms u+s "/bin/${MY_PN}"

	if use udev; then
		insinto /etc/udev/rules.d/
		doins "${FILESDIR}/99-ntfs3g.rules"
	fi

	find "${D}" -name '*.la' -delete
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
