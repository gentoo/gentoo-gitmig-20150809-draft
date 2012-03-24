# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/ntfs3g/ntfs3g-2012.1.15-r1.ebuild,v 1.6 2012/03/24 17:17:43 phajdan.jr Exp $

EAPI=4
inherit linux-info

MY_PN=${PN/3g/-3g}
MY_P=${MY_PN}_ntfsprogs-${PV}

DESCRIPTION="Open source read-write NTFS driver that runs under FUSE"
HOMEPAGE="http://www.tuxera.com/community/ntfs-3g-download/"
SRC_URI="http://tuxera.com/opensource/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ~ppc ~ppc64 ~sparc x86"
IUSE="acl crypt debug extras +ntfsprogs suid static-libs xattr +udev +external-fuse"

RDEPEND="external-fuse? ( >=sys-fs/fuse-2.8.0 )
	crypt? ( net-libs/gnutls )
	!sys-fs/ntfsprogs"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-apps/attr"

S=${WORKDIR}/${MY_P}

DOCS="AUTHORS ChangeLog CREDITS README"

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
		--exec-prefix=/usr \
		--docdir=/usr/share/doc/${PF} \
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
	default

	use suid && fperms u+s /usr/bin/${MY_PN}

	if use udev; then
		insinto /lib/udev/rules.d
		doins "${FILESDIR}"/99-ntfs3g.rules
	fi

	find "${ED}" -name '*.la' -exec rm -f {} +

	# http://bugs.gentoo.org/398069
	dodir /usr/sbin
	mv -vf "${ED}"/sbin/* "${ED}"/usr/sbin || die
	rm -rf "${ED}"/sbin

	dosym mount.ntfs-3g /usr/sbin/mount.ntfs #374197
}
