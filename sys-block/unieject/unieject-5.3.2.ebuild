# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/unieject/unieject-5.3.2.ebuild,v 1.14 2011/03/31 15:35:22 ssuominen Exp $

inherit eutils libtool

DESCRIPTION="Multiplatform command to eject and load CD-Rom drives"
HOMEPAGE="http://www.flameeyes.eu/projects#unieject"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 hppa ~ia64 ppc ppc64 ~sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE="nls pmount"

RDEPEND=">=dev-libs/libcdio-0.77
	dev-libs/popt
	>=dev-libs/confuse-2.5
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	sys-apps/sed
	dev-util/pkgconfig"
RDEPEND="${RDEPEND}
	!sys-block/eject
	pmount? ( sys-apps/pmount )"

pkg_setup() {
	use pmount && enewgroup plugdev
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	elibtoolize
}

src_compile() {
	econf \
		$(use_enable nls) \
		--enable-lock-workaround \
		--disable-dependency-tracking \
		--disable-doc \
		--htmldir=/usr/share/doc/${PF}/html \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README ChangeLog NEWS AUTHORS unieject.conf.sample

	# Symlink to eject to provide a good virtual/eject
	dosym unieject.1.gz /usr/share/man/man1/eject.1.gz
	dosym unieject /usr/bin/eject

	# If we enable support for pmount, we need to change the installed
	# configuration file to enable the unmount wrapper, and we also set the
	# command setuid root but in group plugdev, so that it's inlined with pmount
	# itself.
	if use pmount; then
		fowners root:plugdev /usr/bin/unieject
		fperms 1710 /usr/bin/unieject
		chmod +s "${D}/usr/bin/unieject"

		dodir /etc
		sed -e 's:^# \(unmount-wrapper = \):\1:' \
			"${S}/unieject.conf.sample" \
			> "${D}/etc/unieject.conf"
	fi
}
