# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/pinentry/pinentry-0.7.2-r3.ebuild,v 1.3 2006/04/22 11:56:48 corsair Exp $

inherit flag-o-matic qt3 multilib eutils autotools

DESCRIPTION="Collection of simple PIN or passphrase entry dialogs which utilize the Assuan protocol"
HOMEPAGE="http://www.gnupg.org/aegypten/"
SRC_URI="mirror://gnupg/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="gtk ncurses qt caps"

DEPEND="gtk? ( =x11-libs/gtk+-2* )
	ncurses? ( sys-libs/ncurses )
	qt? ( $(qt_min_version 3.3) )
	!gtk? ( !qt? ( !ncurses? ( sys-libs/ncurses ) ) )
	caps? ( sys-libs/libcap )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PV}-libcap.patch
	AT_M4DIR="m4" eautoreconf
}

src_compile() {
	local myconf=""

	if ! ( use qt || use gtk || use ncurses )
	then
		myconf="--enable-pinentry-curses --enable-fallback-curses"
	fi

	append-ldflags $(bindnow-flags)

	# Issues finding qt on multilib systems
	export QTLIB="${QTDIR}/$(get_libdir)"

	econf \
		--disable-dependency-tracking \
		--enable-maintainer-mode \
		--disable-pinentry-gtk \
		$(use_enable gtk pinentry-gtk2) \
		$(use_enable qt pinentry-qt) \
		$(use_enable ncurses pinentry-curses) \
		$(use_enable ncurses fallback-curses) \
		$(use_with caps libcap) \
		${myconf} \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO || die "dodoc failed"
}

pkg_postinst() {
	einfo "We no longer install pinentry-curses and pinentry-qt SUID root by default."
	einfo "Linux kernels >=2.6.9 support memory locking for unprivileged processes."
	einfo "The soft resource limit for memory locking specifies the limit an"
	einfo "unprivileged process may lock into memory. You can also use POSIX"
	einfo "capabilities to allow pinentry to lock memory. To do so activate the caps"
	einfo "USE flag and add the CAP_IPC_LOCK capability to the permitted set of"
	einfo "your users."
}
