# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/htop/htop-0.8.3-r1.ebuild,v 1.3 2010/09/03 19:00:35 grobian Exp $

EAPI=3
inherit eutils flag-o-matic multilib

DESCRIPTION="interactive process viewer"
HOMEPAGE="http://htop.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux"
IUSE="debug openvz unicode vserver"

DEPEND="sys-libs/ncurses[unicode?]"

pkg_setup() {
	if use elibc_FreeBSD && ! [[ -f ${ROOT}/proc/stat && -f ${ROOT}/proc/meminfo ]]; then
		eerror
		eerror "htop needs /proc mounted to compile and work, to mount it type"
		eerror "mount -t linprocfs none /proc"
		eerror "or uncomment the example in /etc/fstab"
		eerror
		die "htop needs /proc mounted"
	fi

	if ! has_version sys-process/lsof; then
		ewarn "To use lsof features in htop(what processes are accessing"
		ewarn "what files), you must have sys-process/lsof installed."
	fi
}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.8.1-non-printable-char-filter.patch
	sed -i -e '1c\#!'"${EPREFIX}"'/usr/bin/python' \
		scripts/MakeHeader.py || die
}

src_configure() {
	useq debug && append-flags -DDEBUG

	econf \
		$(use_enable openvz) \
		$(use_enable vserver) \
		$(use_enable unicode) \
		--enable-taskstats
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README ChangeLog TODO || die
	rmdir "${ED}"/usr/{include,$(get_libdir)} || die
}
