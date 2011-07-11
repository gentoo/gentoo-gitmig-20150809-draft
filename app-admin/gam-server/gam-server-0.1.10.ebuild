# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/gam-server/gam-server-0.1.10.ebuild,v 1.10 2011/07/11 04:25:40 ssuominen Exp $

inherit autotools eutils flag-o-matic libtool multilib python

MY_PN="gamin"
MY_P=${MY_PN}-${PV}

DESCRIPTION="Library providing the FAM File Alteration Monitor API"
HOMEPAGE="http://www.gnome.org/~veillard/gamin/"
SRC_URI="http://www.gnome.org/~veillard/${MY_PN}/sources/${MY_P}.tar.gz
	mirror://gentoo/${MY_PN}-0.1.9-freebsd.patch.bz2
	http://pkgconfig.freedesktop.org/releases/pkg-config-0.26.tar.gz" # pkg.m4 for eautoreconf

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE="debug kernel_linux"

RDEPEND=">=dev-libs/glib-2
	>=dev-libs/libgamin-0.1.10
	!app-admin/fam
	!<app-admin/gamin-0.1.10"

DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"

	mv -vf "${WORKDIR}"/pkg-config-*/pkg.m4 "${WORKDIR}"/ || die

	# Fix compile warnings; bug #188923
	epatch "${DISTDIR}/${MY_PN}-0.1.9-freebsd.patch.bz2"

	# Fix file-collision due to shared library, upstream bug #530635
	epatch "${FILESDIR}/${P}-noinst-lib.patch"

	# autoconf is required as the user-cflags patch modifies configure.in
	# however, elibtoolize is also required, so when the above patch is
	# removed, replace the following call with a call to elibtoolize
	AT_M4DIR="${WORKDIR}" eautoreconf
}

src_compile() {
	# fixes bug 225403
	#append-flags "-D_GNU_SOURCE"

	if ! has_version dev-util/pkgconfig; then
		export DAEMON_CFLAGS="-I/usr/include/glib-2.0 -I/usr/$(get_libdir)/glib-2.0/include"
		export DAEMON_LIBS="-lglib-2.0"
	fi

	econf \
		--disable-debug \
		--disable-libgamin \
		$(use_enable kernel_linux inotify) \
		$(use_enable debug debug-api)

	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
}
