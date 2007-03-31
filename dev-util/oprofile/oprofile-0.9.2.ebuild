# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/oprofile/oprofile-0.9.2.ebuild,v 1.4 2007/03/31 17:29:52 spock Exp $

inherit eutils qt3 linux-info

DESCRIPTION="A transparent low-overhead system-wide profiler"
HOMEPAGE="http://oprofile.sourceforge.net"
SRC_URI="mirror://sourceforge/oprofile/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
# IUSE: it also needs kernel sources but all gentoo users have them
IUSE="qt3"
DEPEND=">=dev-libs/popt-1.7-r1
	>=sys-devel/binutils-2.14.90.0.6-r3
	>=sys-libs/glibc-2.3.2-r1
	qt3? ( $(qt_min_version 3.3) )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/oprofile-0.9.2-amd64.patch
}

src_compile() {
	local myconf=""

	if use qt3
	then
		REALHOME="$HOME"
		mkdir -p $T/fakehome/.kde
		mkdir -p $T/fakehome/.qt
		export HOME="$T/fakehome"
		addwrite "${QTDIR}/etc/settings"

		# things that should access the real homedir
		[ -d "$REALHOME/.ccache" ] && ln -sf "$REALHOME/.ccache" "$HOME/"
	else
		myconf="${myconf} --with-qt-dir=/void"
	fi

	myconf="${myconf} --with-x"

	case ${KV_FULL} in
	2.2.*|2.4.*) myconf="${myconf} --with-linux=${KV_DIR}";;
	2.5.*|2.6.*) myconf="${myconf} --with-kernel-support";;
	*) die "Kernel version '${KV_FULL}' not supported";;
	esac
	econf ${myconf} || die "econf failed"

	local mymake=""

	sed -i -e "s,depmod -a,:,g" Makefile
	emake ${mymake} || die "emake failed"
}

src_install() {
	local myinst=""

	myinst="${myinst} MODINSTALLDIR=${D}/lib/modules/${KV_FULL}"
	make DESTDIR=${D} ${myinst} install || die "make install failed"

	dodoc ChangeLog* README TODO
}

pkg_postinst() {
	[[ ${ROOT} == / ]] && /sbin/modules-update

	echo
	elog "Now load the oprofile module by running:"
	elog "  # opcontrol --init"
	elog "Then read manpages and this html doc:"
	elog "  /usr/share/doc/oprofile/oprofile.html"
	echo
}
