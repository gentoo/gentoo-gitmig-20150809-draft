# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/gamin/gamin-0.0.10.ebuild,v 1.1 2004/09/21 20:35:57 azarah Exp $

inherit eutils

INOTIFY_VER="0.8.1"

DESCRIPTION="Library providing the FAM File Alteration Monitor API"
HOMEPAGE="http://www.gnome.org/~veillard/gamin/"
SRC_URI="http://www.gnome.org/~veillard/gamin/sources/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=

DEPEND="virtual/libc
	>=dev-libs/glib-2.0
	!app-admin/fam"

PROVIDE="virtual/fam"

src_unpack() {
	unpack ${A}

	cd ${S}/server
	if [ -f "/usr/src/linux/include/linux/inotify.h" ]
	then
		cp /usr/src/linux/include/linux/inotify.h .
	elif [ -f "/usr/include/linux/inotify.h" ]
	then
		cp /usr/include/linux/inotify.h .
	else
		cp "${FILESDIR}/inotify-${INOTIFY_VER}.h" inotify.h
	fi

	cd ${S}

	# Include our inotify.h
	epatch ${FILESDIR}/${PN}-0.0.6-inotify_h-include.patch
	# Only complain about failing to open inotify node if debug is enabled.
	epatch ${FILESDIR}/${PN}-0.0.6-quiet-inotify-warning.patch
	# Cleanup HAVE_LINUX and ENABLE_DNOTIFY usage.  This also allow the
	# DNotify backend to build again if inotify is enabled, as well as
	# fix a build error.
	epatch ${FILESDIR}/${PN}-0.0.10-HAVE_LINUX-and-ENABLE_DNOTIFY-cleanup.patch

	einfo "Running autoreconf (can take a minute or two)..."
	autoreconf &>/dev/null || die "autreconf failed!"
}

src_compile() {
	econf --enable-inotify \
		--enable-debug || die
	# Enable debug for testing the runtime backend patch

	# Currently not smp safe
	emake || die "emake failed"
}

src_install() {
	einstall || die

	dodoc AUTHORS COPYING ChangeLog Copyright README TODO
}
